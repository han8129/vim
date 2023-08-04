require("setup.ibus")

local ibus = IBus()
local defaultLanguages = ibus.getDefault()

local this = {}
this._instance = nil

-- Manage Ibus bamboo
--
-- Turn off iBus VN when enter Vim.
-- If Ibus bamboo (VN) is set in insert mode, switch to US
-- in normal mode.
function IBusController()
    this.getInstance = function()
        if this._instance == nil then
            this.__index = this
            this.needSwitch = false
            this._instance = setmetatable( {}, this )
        end

        return this._instance
    end
    this.on = function()
        if this.needSwitch then
            ibus.setLanguage( defaultLanguages.VI )
        end

    end

    this.off = function()
        if defaultLanguages.EN == ibus.getLanguage() then
            this.needSwitch = false
            return
        end

        ibus.setLanguage( defaultLanguages.EN )
        this.needSwitch = true
    end

    return {
        getInstance = this.getInstance
        ,on = this.on
        ,off = this.off
    }
end
