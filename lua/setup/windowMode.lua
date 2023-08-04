require( "setup.statusLine" )
local expr = { expr = true, noremap = true }

-- Window mode
--
-- Switch focus, close, resize window with out prefix
-- Toggle by <C-w>, Go back to normal mode with <Esc>
local this = {}
this._instance = nil

function WindowMode()
    this.getInstance = function()
        if this._instance == nil then
            this.__index = this
            this.state = "off"
            this._instance = setmetatable( {}, this )
        end

        return this._instance
    end

    this.toggle = function()
        if this.state == "on" then
            this.state = "off"

            SetStatusLine()
            print( " " )
            return
        end

        this.state = "on"
        SetStatusLine( "w" )
        print( "-- WINDOW --" )
    end

    this.getState = function()
        return this.state
    end

    this.remap = function(key, customKey )
        REMAP("n", key
            , function()
                if this.state == "off" then
                    return key
                end

                if customKey then
                    return "<C-w>" .. customKey
                end

                return "<C-w>" .. key
            end
        ,expr)
    end

    return {
        getInstance = this.getInstance
        ,getState = this.getState
        ,toggle = this.toggle
        ,remap = this.remap
    }
end
