require( "setup.Models.Netrw" )

function NetrwController( netrw )
    local this = { netrw = netrw }
    this.__index = this

    local function resize()
        local screenWidth = vim.fn.winwidth(0)

        if (screenWidth <= 106) then
            LET.netrw_winsize = 50
        else
            LET.netrw_winsize = 25
        end

        return true
    end

    local function open()
        if this.netrw.getState() == this.netrw.getDefault().on then
            return false
        end

        this.netrw.setState( this.netrw.getDefault().on )
        return "<cmd>Lex%:p:h<Enter>"
    end


    local function getBufnr( buffer )
        local bufferNumber = vim.fn.bufnr( buffer )

        while (bufferNumber > 1) do
            if (vim.fn.getbufvar( bufferNumber, "&filetype" ) == "netrw" ) then
                return bufferNumber
            end

            bufferNumber = bufferNumber - 1
        end

        return -1
    end

    local function close()
        if this.netrw.getState() == this.netrw.getDefault().off then
            return ""
        end

        local bufferNumber = getBufnr( "$" ) -- get that last buffer

        this.netrw.setState( this.netrw.getDefault().off )
        return "<cmd>bwipeout" .. bufferNumber .. "<Enter>"
    end

    return {
        open = open
        ,close = close
        ,resize = resize
    }
end
