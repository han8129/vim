local this = {}
this.__index = this
this._languages = { EN = "BambooUs", VI = "Bamboo"}

function IBus()
    this.getLanguage = function()
        local currentLanguage = vim.fn.system('ibus engine')

        -- the return value contain newline character
        return string.sub(currentLanguage, 1, -2)
    end

    this.setLanguage = function( language )
        vim.fn.system('ibus engine ' .. language)
    end

    this.getDefault = function()
        return {
            EN = this._languages.EN
            ,VI = this._languages.VI
        }
    end

    return {
        getLanguage = this.getLanguage
        ,setLanguage = this.setLanguage
        ,getDefault = this.getDefault
    }
end
