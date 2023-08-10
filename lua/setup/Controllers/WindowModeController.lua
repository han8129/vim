require( "setup.Models.WindowMode" )

local this = {}
this.__index = this

function WindowModeController()
    this.new = function()
        this.windowMode = WindowMode().getInstance()
        return setmetatable( {}, this )
    end

    this.on = function()
        if this.windowMode.getState() == this.windowMode.getDefault().on then
            return false
        end

        this.windowMode.setState( this.windowMode.getDefault().on )
        SetStatusLine( "w" )
        print( "-- WINDOW --" )

        return true
    end

    this.off = function()
        if this.windowMode.getState() == this.windowMode.getDefault().off then
            return false
        end

        this.windowMode.setState( this.windowMode.getDefault().off )
        SetStatusLine()
        print( " " )

        return true
    end
    this.specificFiles = function()
        if this.windowMode.getState() == this.windowMode.getDefault().off then
            return
        end

        local pattern = { 'netrw', 'fugitive', 'help' }

        local buffer = vim.bo.ft

        for _, filetype in ipairs(pattern) do
            if filetype == buffer then
                this.off()
                return
            end
        end
    end

    return {
        new = this.new
        ,on = this.on
        ,off = this.off
        ,specificFiles = this.specificFiles
    }
end
