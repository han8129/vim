local this = {}
this.__index = this
this._instance = nil

function IBus()
    function this.getInstance()
        if this._instance == nil then
            this._languages = { EN = "BambooUs", VI = "Bamboo"}
            this._instance = setmetatable( {}, this )
        end

        return {
            getLanguage = this._instance.getLanguage
            ,setLanguage = this._instance.setLanguage
            ,getDefault = this._instance.getDefault
        }
    end
    this.getLanguage = function()
        local currentLanguage = vim.fn.system('ibus engine')

        -- the return value contain newline character
        return string.sub(currentLanguage, 1, -2)
    end

    this.setLanguage = function( language )
        for _, value in pairs( this._languages ) do
            if value == language then
                vim.fn.system( 'ibus engine ' .. value )
                return true
            end
        end

        return false
    end

    this.getDefault = function()
        local clone = {}

        for key, value in pairs(this._languages) do
            clone[key] = value
        end

        return clone
    end

    return {
        getInstance = this.getInstance
        ,getLanguage = this.getLanguage
        ,setLanguage = this.setLanguage
        ,getDefault = this.getDefault
    }
end
