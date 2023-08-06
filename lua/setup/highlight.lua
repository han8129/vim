vim.cmd([[
    let terminal_green = "#4AF626"

    highlight Normal guifg=green

    highlight String guifg=green

    highlight Number guifg=green

    highlight Constant guifg=green

    highlight Type guifg=green

    highlight Statement gui=italic guifg=#4af626

    highlight Preproc guifg=green

    highlight Identifier guifg=green

    highlight Comment guifg=gray gui=italic

    highlight CursorlineNr guifg=#4af626

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

    highlight ModeMsg guifg=#4AF626
]])

vim.cmd("highlight Visual guifg=white gui=italic guibg=" .. COLOR['red1'])
vim.cmd("highlight ErrorMsg gui=NONE guifg=white guibg=" .. COLOR['red1'])
