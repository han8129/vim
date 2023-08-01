-- Window mode
--
-- Switch focus, close, resize window with out prefix
-- Toggle by <C-w>, Go back to normal mode with <Esc>

local options = { expr = true, noremap = true }

WindowMode = "disabled"

function WindowModeToggle()
    if WindowMode == "active" then
        WindowMode = "disabled"
        print( " " )
    else
        WindowMode = "active"
        print( "-- WINDOW --" )
    end

    -- Change Status line color to magenta
    SetStatusLine()
end

AUTOCMD_GROUP( 'window_mode', { clear = true } );

-- Disable Window Mode in Insert Mode
AUTOCMD(
    'InsertEnter', {
    group = "window_mode",
    callback = function()
        if WindowMode == "ative" then
            WindowModeToggle()
        end
    end
})

-- Disable Window Mode in certain filetype
AUTOCMD('WinEnter', {
    group = "window_mode"
    ,callback = function()
        if WindowMode == "disabled" then
            return
        end

        local pattern = { 'netrw', 'fugitive', 'help' }

        local buffer = vim.bo.ft

        for _, filetype in ipairs(pattern) do
            if filetype == buffer then
                WindowModeToggle()
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
    if (WindowMode == "active") then
        return "<C-w>"
    end

    WindowModeToggle()
end
, options)

REMAP("n", "<Esc>"
, function()
    if WindowMode == "disabled" then
        return "<cmd>nohls<Enter>"
    end

    WindowModeToggle()
end
, options)

REMAP("n", "v"
, function()
    if WindowMode == "active" then
        return "<C-w>v"
    end

    return "<C-q>"
end
, options)


REMAP("n", "J"
, function()
    if WindowMode == "active" then
        return "<C-w>J"
    end

    return "mzJ`z"
end
, options)

REMAP("n", "H"
, function()
    if WindowMode == "active" then
        return "<cmd>wincmd H<Enter>"
    end

    return "H"
end
, options)

REMAP("n", "K"
, function()
    if (WindowMode == "active") then
        return "<cmd>wincmd K<Enter>"
    end

    return '<CMD>lua _G.show_docs()<CR>'
end
, options)

REMAP("n", "L", function()
    if WindowMode == "active" then
        return "<cmd>wincmd L<Enter>"
    end

    return "L"
end
, options)

REMAP("n", "s"
, function()
    if WindowMode == "active" then
        return "<cmd>wincmd s<Enter>"
    end

    return "s"
end
, options)

REMAP("n", "h"
, function()
    if WindowMode == "active" then
        return "<cmd>wincmd h<Enter>"
    end

    return "h"
end
, options)

REMAP("n", "j"
, function()
    if WindowMode == "active" then
        return "<cmd>wincmd j<Enter>"
    end

    return "j"
end
, options)

REMAP("n", "k"
, function()
    if WindowMode == "active" then
        return "<cmd>wincmd k<Enter>"
    end

    return "k"
end
, options)

REMAP("n", "l"
, function()
    if WindowMode == "active" then
        return "<C-w>l"
    end

    return "l"
end
, options)

REMAP("n", "x"
, function()
    if WindowMode == "active" then
        return "<C-w>c"
    end

    return "x"
end
, options)

REMAP("n", "o"
, function()
    if WindowMode == "active" then
        WindowModeToggle()

        return "<C-w>o"
    end

    return "o"
end
, options)

REMAP("n", "="
, function()
    if (WindowMode == "active") then
        return "<C-w>5+"
    end

    return "="
end
, options)

REMAP("n", "-"
, function()
    if WindowMode == "active" then
        return "<C-w>5-"
    end

    return "-"
end
, options)

REMAP("n", "+"
, function()
    if WindowMode == "active" then
        return "<C-w>="
    end

    return "+"
end
, options)

REMAP("n", "0"
, function()
    if WindowMode == "active" then
        return "<C-w>10>"
    end

    return "0"
end
, options)

REMAP("n", "9"
, function()
    if WindowMode == "active" then
        return "<C-w>10<"
    end

    return "9"
end
, options)

REMAP("n", "f"
, function()
    if WindowMode == "active" then
        return "<C-w>_<C-w>|"
    end

    return "<Plug>(leap-forward-to)"
end
, options)
