vim.b.terminal_green = COLOR.green
vim.b.red = COLOR.red1

vim.cmd([[

    execute "highlight Normal gui=none guifg=" b:terminal_green

    execute "highlight String gui=none guifg=" b:terminal_green

    execute "highlight Number gui=none guifg=" b:terminal_green

    execute "highlight Constant gui=none guifg=" b:terminal_green

    execute "highlight Type gui=none guifg=" b:terminal_green

    "" To pass variable to a command
    execute "highlight Statement gui=none guifg=" b:terminal_green

    execute "highlight Preproc gui=none guifg=" b:terminal_green

    execute "highlight Identifier gui=none guifg=" b:terminal_green

    highlight Comment guifg=gray gui=italic

    execute "highlight CursorlineNr guifg=" b:terminal_green

    highlight Search guibg=yellow guifg=black gui=italic
    highlight IncSearch guibg=red guifg=white gui=italic
    highlight CurSearch guibg=red guifg=white gui=italic

    highlight DiagnosticHint guifg=yellow
    highlight FileStatus guibg=red guifg=white

    highlight FormatWarning guibg=yellow guifg=black

    call matchadd('FormatWarning', '\%79v', 100)

    match FormatWarning /\s$/

    highlight EndOfBuffer guifg=black

    highlight Pmenu guifg=gray guibg=black

    execute "highlight ModeMsg guifg=" b:terminal_green
    execute "highlight Visual guifg=white gui=italic guibg=" b:red
    execute "highlight ErrorMsg gui=NONE guifg=white guibg=" b:red
]])

