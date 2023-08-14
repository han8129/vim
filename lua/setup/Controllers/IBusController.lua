require("setup.Models.IBus")

-- Manage Ibus bamboo
--
-- Turn off iBus VN when enter Vim.
-- If Ibus bamboo (VN) is set in insert mode, switch to US
-- in normal mode.
function IBusController( ibus )
       local this = { needSwitch = false, ibus = ibus }
       this.__index = this

       local function on()
              if this.needSwitch then
                     this.ibus.setLanguage( this.ibus.getDefault().VI )
              end

       end

       local function off()
              if this.ibus.getDefault().EN == this.ibus.getLanguage() then
                     this.needSwitch = false
                     return
              end

              this.ibus.setLanguage( this.ibus.getDefault().EN )
              this.needSwitch = true
       end

       return {
              on = on
              ,off = off
       }
end
