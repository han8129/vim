require( "setup.Models.WindowMode" )
require( "setup.EventManager" )

local this = {}
this.__index = this

function WindowModeController()
    this.new = function()
        this.windowMode = WindowMode().getInstance()
        return setmetatable( {}, this )
    end

    this.toggle = function()
        if this.windowMode.getState() == this.windowMode.getDefault().on then
            this.windowMode.setState( this.windowMode.getDefault().off )

            SetStatusLine()
            print( " " )
            return
        end

        this.windowMode.setState( this.windowMode.getDefault().on )
        SetStatusLine( "w" )
        print( "-- WINDOW --" )
    end

    this.specificFiles = function()
        if this.windowMode.getState() == this.windowMode.getDefault().off then
            return
        end

        local pattern = { 'netrw', 'fugitive', 'help' }

        local buffer = vim.bo.ft

        for _, filetype in ipairs(pattern) do
            if filetype == buffer then
                this.toggle()
                return
            end
        end
    end

    return {
        new = this.new
        ,toggle = this.toggle
        ,specificFiles = this.specificFiles
    }
end
