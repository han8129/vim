local EN = 'BambooUs'
local VI = 'Bamboo'
local IBUS_PREVIOUS = ''

function IBusOff()
    local ibus_current = vim.fn.system('ibus engine')

    if ibus_current == EN then
        return
    end

    IBUS_PREVIOUS = ibus_current

    vim.fn.system('ibus engine BambooUs')
end

function IBusOn()
    local ibus_current = vim.fn.system('ibus engine')

    if ibus_current == VI then
        return
    end

    vim.fn.system('ibus engine ' .. IBUS_PREVIOUS)
end

IBusOff()

vim.cmd([[

augroup IBusHandler
autocmd!
" Khôi phục ibus engine khi tìm kiếm
autocmd CmdLineEnter [/?] silent lua IBusOn()
autocmd CmdLineLeave [/?] silent lua IBusOff()
autocmd CmdLineEnter \? silent lua IBusOn()
autocmd CmdLineLeave \? silent lua IBusOff()
" Khôi phục ibus engine khi vào insert mode
autocmd InsertEnter * silent lua IBusOn()
" Tắt ibus engine khi vào normal mode
autocmd InsertLeave * silent lua IBusOff()

autocmd VimEnter * silent lua IBusOff()
autocmd VimLeave * silent lua IBusOn()

autocmd FocusGained * silent lua IBusOff()

augroup END
]])
