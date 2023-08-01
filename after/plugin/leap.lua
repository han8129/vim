local leap = require('leap')

leap.opts.special_keys = {

    next_target = '<nop>'
    ,prev_target = '<nop>'
    ,next_group = '<nop>'
    ,prev_group = '<nop>'
    ,multi_accept = '<nop>'
    ,multi_revert = '<nop>'

}

-- (leap-forward-to) @see winmode.lua
vim.keymap.set( 'n', 'F', '<Plug>(leap-backward-to)' )
vim.keymap.set( 'n', 't', '<Plug>(leap-forward-till)' )
vim.keymap.set( 'n', 'T', '<Plug>(leap-backward-till)' )

vim.cmd([[

highlight LeapLabelPrimary gui=italic guifg=white guibg=red

highlight LeapLabelSecondary gui=NONE guifg=black guibg=yellow

highlight LeapLabelSecondary gui=NONE guifg=black guibg=yellow

highlight LeapBackDrop gui=NONE guifg=gray guibg=NONE

]])
