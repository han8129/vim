require("setup.packer")
require("setup.set")
require("setup.remap")
require("setup.netrw")
require("setup.autoswap")
require("setup.statusLine")
require("setup.windowMode")
require("setup.ibus")
require("setup.highlight")
-- require("setup.indentation")

local ThePrimeagenGroup = AUTOCMD_GROUP('ThePrimeagen', {})

local yank_group = AUTOCMD_GROUP('HighlightYank', {})

local expr = { expr = true, noremap = true }

local windowMode = WindowMode().new()

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
        if windowMode.getState() == "on" then
            SetStatusLine("w")
            return
        end

        SetStatusLine( vim.fn.mode() )
    end
})

AUTOCMD( "BufEnter", {
    group = "StatusLine"
    ,callback = function()
        SetGitBranch()
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
    if (windowMode.getState() == "on") then
        return "<C-w>"
    end

    windowMode.toggle()
end
, expr)

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

REMAP("n", "H"
, function()
    if windowMode.getState() == "on" then
        return "<cmd>wincmd H<Enter>"
    end

    return "H"
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

REMAP("n", "L", function()
    if windowMode == "on" then
        return "<cmd>wincmd L<Enter>"
    end

    return "L"
end
, expr)

REMAP("n", "s"
, function()
    if windowMode.getState() == "on" then
        return "<cmd>wincmd s<Enter>"
    end

    return "s"
end
, expr)

REMAP("n", "h"
, function()
    if windowMode.getState() == "on" then
        return "<cmd>wincmd h<Enter>"
    end

    return "h"
end
, expr)

REMAP("n", "j"
, function()
    if windowMode.getState() == "on" then
        return "<cmd>wincmd j<Enter>"
    end

    return "j"
end
, expr)

REMAP("n", "k"
, function()
    if windowMode.getState() == "on" then
        return "<cmd>wincmd k<Enter>"
    end

    return "k"
end
, expr)

REMAP("n", "l"
, function()
    if windowMode.getState() == "on" then
        return "<C-w>l"
    end

    return "l"
end
, expr)

REMAP("n", "x"
, function()
    if windowMode.getState() == "on" then
        return "<C-w>c"
    end

    return "x"
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

REMAP("n", "="
, function()
    if (windowMode.getState() == "on") then
        return "<C-w>5+"
    end

    return "="
end
, expr)

REMAP("n", "-"
, function()
    if windowMode.getState() == "on" then
        return "<C-w>5-"
    end

    return "-"
end
, expr)

REMAP("n", "+"
, function()
    if windowMode.getState() == "on" then
        return "<C-w>="
    end

    return "+"
end
, expr)

REMAP("n", "0"
, function()
    if windowMode.getState() == "on" then
        return "<C-w>10>"
    end

    return "0"
end
, expr)

REMAP("n", "9"
, function()
    if windowMode.getState() == "on" then
        return "<C-w>10<"
    end

    return "9"
end
, expr)

REMAP("n", "f"
, function()
    if windowMode.getState() == "on" then
        return "<C-w>_<C-w>|"
    end

    return "<Plug>(leap-forward-to)"
end
, expr)
