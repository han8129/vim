-- Window mode
--
-- Switch focus, close, resize window with out prefix
-- Toggle by <C-w>, Go back to normal mode with <Esc>
function WindowMode()
    local obj = {}

    function obj.new()
        if obj._instance then
            return obj._instance
        end

        obj._state = "off"
        obj.__index = obj
        obj._instance = setmetatable({}, obj)

        return obj._instance
    end

    function obj.getState()
        return obj._state
    end

    function obj.toggle()
        if obj._state == "on" then
            obj._state = "off"

            print( " " )
            return
        end

        obj._state = "on"
        print( "-- WINDOW --")
    end

    return obj
end
