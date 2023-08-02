-- Manage Ibus bamboo
--
-- Turn off iBus VN when enter Vim.
-- If Ibus bamboo (VN) is set in insert mode, switch to US
-- in normal mode.
function IBusManager()
    local obj = {}

    obj.__index = obj
    obj._EN = 'BambooUs'
    obj._VI = 'Bamboo'
    obj._needSwitch = false

    function obj.new()
        if obj._instance then
            return obj._instance
        end

        obj._instance = setmetatable({}, obj)
        return obj._instance
    end

    local function setLanguage( language )
        vim.fn.system('ibus engine ' .. language)
    end

    local function getCurrentLanguage()
        local currentLanguage = vim.fn.system('ibus engine')
        -- the return value contain newline character
        return string.sub(currentLanguage, 1, -2)
    end

    function obj.on()
        if obj._needSwitch then
            setLanguage( obj._VI )
        end

    end

    function obj.off()
        if obj._EN == getCurrentLanguage() then
            obj._needSwitch = false
            return
        end

        setLanguage( obj._EN )
        obj._needSwitch = true
    end

    setLanguage( obj._EN )
    return obj
end
