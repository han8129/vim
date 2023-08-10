require( "setup.Models.Netrw" )

local this = {}
this.__index = this
this.netrw = Netrw().getInstance()

function NetrwController()
    this.new = function()
        return setmetatable( {}, this)
    end

    this.resize = function()
        local screenWidth = vim.fn.winwidth(0)

        if (screenWidth <= 106) then
            LET.netrw_winsize = 50
        else
            LET.netrw_winsize = 25
        end

        return true
    end

    this.open = function()
        this.netrw.setState( this.netrw.getDefault().on )
        this.netrw.map()
        return true
    end


    this.close = function()
        local bufferNumber = vim.fn.bufnr("$") -- get number of the last buffer
        while (bufferNumber > 0) do
            if (vim.fn.getbufvar( bufferNumber, "&filetype") == "netrw" ) then

                this.netrw.setState( this.netrw.getDefault().off )
                -- not sure why this not work
                -- vim.cmd( "bwipeout" ..  bufferNumber )
                return true
            end

            bufferNumber = bufferNumber - 1
        end

        return false
    end

    return {
        new = this.new
        ,open = this.open
        ,close = this.close
        ,resize = this.resize
    }
end
