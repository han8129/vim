vim.cmd([[

" Vim global plugin for automating response to swapfiles
" Maintainer: Gioele Barabucci
" Author:     Damian Conway
" License:    This file is placed in the public domain.

"#############################################################
"##                                                         ##
"##  Handle swapfiles automagically...                      ##
"##     * If another session active jump to that screen     ##
"##     * If swapfile newer than file, open read-only       ##
"##     * If swapfile older than file, delete swapfile      ##
"##                                                         ##
"##  Note that this plugin only works if your Vim           ##
"##  configuration includes:                                ##
"##                                                         ##
"##     set title titlestring=                              ##
"##                                                         ##
"##  On MacOS X this plugin works only for Vim sessions     ##
"##  running in Terminal.                                   ##
"##                                                         ##
"##  On Linux this plugin requires the external program     ##
"##  wmctrl, packaged for most distributions.               ##
"##                                                         ##
"##  See below for the two functions that would have to be  ##
"##  rewritten to port this plugin to other OS's.           ##
"##                                                         ##
"#############################################################


" If already loaded, we're done...
if exists("loaded_autoswap")
    finish
endif
let loaded_autoswap = 1

" Preserve external compatibility options, then enable full vim compatibility...
let s:save_cpo = &cpo
set cpo&vim

" Invoke the behaviour whenever a swapfile is detected...
"
augroup AutoSwap
    autocmd!
    autocmd SwapExists *  call AS_HandleSwapfile(expand('<afile>:p'))
augroup END


" The automatic behaviour...
"
function! AS_HandleSwapfile (filename)

    " Is file already open in another Vim session in some other window?
    let active_window = AS_DetectActiveWindow(a:filename)

    " If so, go there instead and terminate this attempt to open the file...
    if (strlen(active_window) > 0)
        call AS_DelayedMsg('Switched to existing session in another window')
        call AS_SwitchToActiveWindow(active_window)
        let v:swapchoice = 'q'

    " Otherwise, if swapfile is older than file itself, just get rid of it...
    elseif getftime(v:swapname) < getftime(a:filename)
        call AS_DelayedMsg("Old swapfile detected...and deleted")
        call delete(v:swapname)
        let v:swapchoice = 'e'

    " Otherwise, open file read-only...
    else
        call AS_DelayedMsg("Swapfile detected...opening read-only")
        let v:swapchoice = 'o'
    endif
endfunction


" Print a message after the autocommand completes
" (so you can see it, but don't have to hit <ENTER> to continue)...
"
function! AS_DelayedMsg (msg)
    " A sneaky way of injecting a message when swapping into the new buffer...
    augroup AutoSwap_Msg
        autocmd!
        " Print the message on finally entering the buffer...
        autocmd BufWinEnter *  echohl WarningMsg
  exec 'autocmd BufWinEnter *  echon "\r'.printf("%-60s", a:msg).'"'
        autocmd BufWinEnter *  echohl NONE

        " And then remove these autocmds, so it's a "one-shot" deal...
        autocmd BufWinEnter *  augroup AutoSwap_Msg
        autocmd BufWinEnter *  autocmd!
        autocmd BufWinEnter *  augroup END
    augroup END
endfunction


"#################################################################
"##                                                             ##
"##  To port this plugin to other operating systems             ##
"##                                                             ##
"##    1. Rewrite the Detect and the Switch function            ##
"##    2. Add a new elseif case to the list of OS               ##
"##                                                             ##
"#################################################################

" Return an identifier for a terminal window already editing the named file
" (Should either return a string identifying the active window,
"  or else return an empty string to indicate "no active window")...
"
function! AS_DetectActiveWindow (filename)
    if has('unix')
        let active_window = AS_DetectActiveWindow_Linux(a:filename)
    endif
    return active_window
endfunction

" LINUX: Detection function for Linux, uses mwctrl
function! AS_DetectActiveWindow_Linux (filename)
    let shortname = fnamemodify(a:filename,":t")
    let find_win_cmd = 'wmctrl -l | grep -i " '.shortname.' .*vim" | tail -n1 | cut -d" " -f1'
    let active_window = system(find_win_cmd)
    return (active_window =~ '0x' ? active_window : "")
endfunction

" Switch to terminal window specified...
"
function! AS_SwitchToActiveWindow (active_window)
    if has('macunix')
        call AS_SwitchToActiveWindow_Mac(a:active_window)
    elseif has('unix')
        call AS_SwitchToActiveWindow_Linux(a:active_window)
    endif
endfunction

" LINUX: Switch function for Linux, uses wmctrl
function! AS_SwitchToActiveWindow_Linux (active_window)
    call system('echo wmctrl -i -a "'.a:active_window.'" >> ~/VIM-log')
    call system('wmctrl -i -a "'.a:active_window.'"')
endfunction

" Restore previous external compatibility options
let &cpo = s:save_cpo

]])

