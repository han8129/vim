require( "setup.statusLine" )
local expr = { expr = true, noremap = true }

-- Window mode
--
-- Switch focus, close, resize window with out prefix
-- Toggle by <C-w>, Go back to normal mode with <Esc>
local this = {}
this.__index = this
this._instance = nil
this.default = { on = true, off = false }

function WindowMode()
    this.getInstance = function()
        if this._instance == nil then
            this.state = this.default.off
            this._instance = setmetatable( {}, this )
        end

        return this._instance
    end

    this.getState = function()
        return this.state
    end

    this.getDefault = function()
        local clone = {}

        for key, value in pairs( this.default ) do
            clone[key] = value
        end

        return clone
    end

    this.setState = function( state )
        for _, value in pairs( this.default ) do
            if state == value then
                this.state = value
                return true
            end
        end

        return false
    end

    this.remap = function( key, customKey )
        REMAP("n", key
            , function()
                if this.state == this.default.off then
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
        ,getDefault = this.getDefault
        ,getState = this.getState
        ,setState = this.setState
        ,remap = this.remap
    }
end
