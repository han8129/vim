require("setup.Models.IBus")

local this = {}
this.__index = this
this.needSwitch = false

-- Manage Ibus bamboo
--
-- Turn off iBus VN when enter Vim.
-- If Ibus bamboo (VN) is set in insert mode, switch to US
-- in normal mode.
function IBusController()
    function this.new()
        this.ibus = IBus().getInstance()
        return setmetatable( {}, this )
    end

    function this.on()
        if this.needSwitch then
            this.ibus.setLanguage( this.ibus.getDefault().VI )
        end

    end

    function this.off()
        if this.ibus.getDefault().EN == this.ibus.getLanguage() then
            this.needSwitch = false
            return
        end

        this.ibus.setLanguage( this.ibus.getDefault().EN )
        this.needSwitch = true
    end

    return {
        new = this.new
        ,on = this.on
        ,off = this.off
    }
end
