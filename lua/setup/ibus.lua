-- Manage Ibus bamboo
--
-- Turn off iBus VN when enter Vim.
-- If Ibus bamboo (VN) is set in insert mode, switch to US
-- in normal mode.
function IBusManager()
    local obj = {}

    function obj.new()
        if obj._instance then
            return obj._instance
        end

        obj.__index = obj
        obj._EN = 'BambooUs'
        obj._VI = 'Bamboo'
        obj._previousState = 'BambooUs'
        obj._instance = setmetatable({}, obj)

        return obj._instance
    end

    vim.fn.system('iBus engine BambooUs')

    local function on()
        vim.fn.system('iBus engine ' .. obj._VI)
    end

    local function off()
        vim.fn.system('iBus engine ' .. obj._EN)
    end

    local function getCurrentState()
        return vim.fn.system('iBus engine')
    end

    function obj.on()
        if obj._previousState == obj._VI then
            on()
        end
    end

    function obj.off()
        local state = getCurrentState()

        if state == obj._EN then
            return false
        end

        off()

        obj._previousState = state
    end

    return obj
end

iBus = IBusManager().new()

vim.cmd([[

augroup IBusHandler
autocmd!
" Khôi phục iBus engine khi tìm kiếm
autocmd CmdLineEnter [/?] silent lua iBus.on()
autocmd CmdLineLeave [/?] silent lua iBus.off()
autocmd CmdLineEnter \? silent lua iBus.on()
autocmd CmdLineLeave \? silent lua iBus.off()
" Khôi phục iBus engine khi vào insert mode
autocmd InsertEnter * silent lua iBus.on()
" Tắt iBus engine khi vào normal mode
autocmd InsertLeave * silent lua iBus.off()

autocmd VimEnter * silent lua iBus.off()

autocmd FocusGained * silent lua iBus.off()

augroup END
]])
