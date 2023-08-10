local options = {
    netrw_banner = 0,
    netrw_browse_split = 4,
    netrw_liststyle = 0,
    netrw_preview = 1,
    netrw_altv = 1,
    netrw_localcopydircmd = 'cp -r',
}

local this = {}
this.__index = this
this._instance = nil

function Netrw()
    this.getInstance = function()
        if this._instance == nil then
            -- setup netrw configurations
            for key, value in pairs( options ) do
                LET[key] = value
            end

            this.default = { on = true, off = false }
            this.state = this.default.off
            this._instance = true
        end

        return {
            getDefault = this.getDefault
            ,getState = this.getState
            ,setState = this.setState
            ,map = this.map
        }
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

    this.map = function()
        vim.cmd([[

        nmap <buffer> h -^
        nmap <buffer> l <Enter>
        nmap <buffer> . gh
        nmap <buffer> v <nop>
        nmap <buffer> p <nop>
        nmap <buffer> o <nop>
        nmap <buffer> <C-w> <C-w>

        ]])
    end

    return {
        getInstance = this.getInstance
    }
end
