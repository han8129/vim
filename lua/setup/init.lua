local expr = { expr = true, noremap = true }

require("setup.packer")
require("setup.set")
require("setup.remap")
require("setup.netrw")
require("setup.autoswap")
require("setup.statusLine")
require("setup.windowMode")
require("setup.ibus")
require("setup.ibusManager")
require("setup.highlight")
-- require("setup.indentation")

-- turn off Ibus when entering vim
local ibus = IBus()
local eng = ibus.getDefault().EN
ibus.setLanguage( eng )

local ThePrimeagenGroup = AUTOCMD_GROUP('ThePrimeagen', {})

local yank_group = AUTOCMD_GROUP('HighlightYank', {})

local windowMode = WindowMode().getInstance()

local ibusController = IBusController().getInstance()

function R(name)
    require("plenary.reload").reload_module(name)
end

AUTOCMD('TextYankPost', {
    group = yank_group,
    pattern = '*',
    callback = function()
        vim.highlight.on_yank({
            higroup = 'IncSearch',
            timeout = 40,
        })
    end,
})

AUTOCMD({"BufWritePre"}, {
    group = ThePrimeagenGroup,
    pattern = "*",
    command = [[%s/\s\+$//e]],
})

AUTOCMD_GROUP( 'StatusLine', { clear = true, });

AUTOCMD('ModeChanged', {
    group = "StatusLine"
    ,callback = function ()
        if windowMode.getState() == "off" then
            SetStatusLine()
        end
    end
})

AUTOCMD( "BufEnter", {
    group = "StatusLine"
    ,callback = function()
        SetGitBranch()
    end
})

AUTOCMD_GROUP( 'IBus', { clear = true } );

AUTOCMD( "CmdLineEnter", {
    group = "IBus"
    ,callback = function()
        ibusController.on()
    end
})

AUTOCMD( "InsertEnter", {
    group = "IBus"
    ,callback = function()
        ibusController.on()
    end
})

AUTOCMD( "CmdLineLeave", {
    group = "IBus"
    ,callback = function()
        ibusController.off()
    end
})

AUTOCMD( "InsertLeave", {
    group = "IBus"
    ,callback = function()
        ibusController.off()
    end
})

AUTOCMD_GROUP( 'window_mode', { clear = true } );

-- Disable Window Mode in Insert Mode
AUTOCMD(
    'InsertEnter', {
    group = "window_mode",
    callback = function()
        if windowMode.getState() == "on" then
            windowMode.toggle()
        end
    end
})

-- Disable Window Mode in certain filetype
AUTOCMD('WinEnter', {
    group = "window_mode"
    ,callback = function()
        if windowMode.getState() == "off" then
            return
        end

        local pattern = { 'netrw', 'fugitive', 'help' }

        local buffer = vim.bo.ft

        for _, filetype in ipairs(pattern) do
            if filetype == buffer then
                windowMode.toggle()
                return
            end
        end
    end,
})

AUTOCMD('WinLeave', {
    group = "window_mode"
    ,command = 'setlocal nocursorline'
})

AUTOCMD('WinEnter', {
    group = "window_mode"
    ,command = 'setlocal cursorline'
})

REMAP("n", "<C-w>"
, function()
    if windowMode.getState() == "on" then
        return "<C-w>"
    end

    windowMode.toggle()
end
, expr)

-- Window mode remap
REMAP("n", "<Esc>"
, function()
    if windowMode.getState() == "off" then
        return "<cmd>nohls<Enter>"
    end

    windowMode.toggle()
end
, expr)

REMAP("n", "v"
, function()
    if windowMode.getState() == "on" then
        return "<C-w>v"
    end

    return "<C-q>"
end
, expr)


REMAP("n", "J"
, function()
    if windowMode.getState() == "on" then
        return "<C-w>J"
    end

    return "mzJ`z"
end
, expr)

REMAP("n", "K"
, function()
    if (windowMode.getState() == "on") then
        return "<cmd>wincmd K<Enter>"
    end

    return '<CMD>lua _G.show_docs()<CR>'
end
, expr)

REMAP("n", "o"
, function()
    if windowMode.getState() == "on" then
        windowMode.toggle()

        return "<C-w>o"
    end

    return "o"
end
, expr)

windowMode.remap("H")

windowMode.remap("L")

windowMode.remap("s")

windowMode.remap("h")

windowMode.remap("j")

windowMode.remap("k")

windowMode.remap("l")

windowMode.remap("x", "c")

windowMode.remap( "=", "5+" )

windowMode.remap( '-', '5-')

windowMode.remap( "+", "=" )

windowMode.remap( "0", "10>")

windowMode.remap( "9", "10<")
