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

            return
        end

        obj._state = "on"
    end

    return obj
end
