local options = { expr = true, noremap = true }

-- Window mode
--
-- Switch focus, close, resize window with out prefix
-- Toggle by <C-w>, Go back to normal mode with <Esc>
function WindowMode(super)
    local obj = {_state = "off"}
    obj.__index = obj
    setmetatable(obj, super)

    function obj.new(...)
        if obj._instance then
            return obj._instance
        end

        local instance = setmetatable({}, obj)
        if instance.ctor then
            instance:ctor(...)
        end

        obj._instance = instance
        return obj._instance
    end

    function obj.getState()
        return obj._state
    end

    function obj.toggle()
        if obj._state == "on" then
            obj._state = "off"

            print(" ")
            return
        end

        obj._state = "on"

        print("-- WINDOW --")
        SetStatusLine()
    end

    return obj
end

local windowMode = WindowMode().new()


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
, options)

REMAP("n", "<Esc>"
, function()
    if windowMode.getState() == "off" then
        return "<cmd>nohls<Enter>"
    end

    windowMode.toggle()
end
, options)

REMAP("n", "v"
, function()
    if windowMode.getState() == "on" then
        return "<C-w>v"
    end

    return "<C-q>"
end
, options)


REMAP("n", "J"
, function()
    if windowMode.getState() == "on" then
        return "<C-w>J"
    end

    return "mzJ`z"
end
, options)

REMAP("n", "H"
, function()
    if windowMode.getState() == "on" then
        return "<cmd>wincmd H<Enter>"
    end

    return "H"
end
, options)

REMAP("n", "K"
, function()
    if (windowMode.getState() == "on") then
        return "<cmd>wincmd K<Enter>"
    end

    return '<CMD>lua _G.show_docs()<CR>'
end
, options)

REMAP("n", "L", function()
    if windowMode == "on" then
        return "<cmd>wincmd L<Enter>"
    end

    return "L"
end
, options)

REMAP("n", "s"
, function()
    if windowMode.getState() == "on" then
        return "<cmd>wincmd s<Enter>"
    end

    return "s"
end
, options)

REMAP("n", "h"
, function()
    if windowMode.getState() == "on" then
        return "<cmd>wincmd h<Enter>"
    end

    return "h"
end
, options)

REMAP("n", "j"
, function()
    if windowMode.getState() == "on" then
        return "<cmd>wincmd j<Enter>"
    end

    return "j"
end
, options)

REMAP("n", "k"
, function()
    if windowMode.getState() == "on" then
        return "<cmd>wincmd k<Enter>"
    end

    return "k"
end
, options)

REMAP("n", "l"
, function()
    if windowMode.getState() == "on" then
        return "<C-w>l"
    end

    return "l"
end
, options)

REMAP("n", "x"
, function()
    if windowMode.getState() == "on" then
        return "<C-w>c"
    end

    return "x"
end
, options)

REMAP("n", "o"
, function()
    if windowMode.getState() == "on" then
        windowMode.toggle()

        return "<C-w>o"
    end

    return "o"
end
, options)

REMAP("n", "="
, function()
    if (windowMode.getState() == "on") then
        return "<C-w>5+"
    end

    return "="
end
, options)

REMAP("n", "-"
, function()
    if windowMode.getState() == "on" then
        return "<C-w>5-"
    end

    return "-"
end
, options)

REMAP("n", "+"
, function()
    if windowMode.getState() == "on" then
        return "<C-w>="
    end

    return "+"
end
, options)

REMAP("n", "0"
, function()
    if windowMode.getState() == "on" then
        return "<C-w>10>"
    end

    return "0"
end
, options)

REMAP("n", "9"
, function()
    if windowMode.getState() == "on" then
        return "<C-w>10<"
    end

    return "9"
end
, options)

REMAP("n", "f"
, function()
    if windowMode.getState() == "on" then
        return "<C-w>_<C-w>|"
    end

    return "<Plug>(leap-forward-to)"
end
, options)
