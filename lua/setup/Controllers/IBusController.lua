require("setup.Models.IBus")

local this = { needSwitch = false, ibus = IBus()}
this.__index = this

-- Manage Ibus bamboo
--
-- Turn off iBus VN when enter Vim.
-- If Ibus bamboo (VN) is set in insert mode, switch to US
-- in normal mode.
function IBusController( ibus )
       if getmetatable( ibus ) == nil
              or getmetatable( ibus ) ~= getmetatable( IBus() )
       then
              error( "Not allowed" )
       end

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

       local function getNeedSwitch()
            return this.needSwitch
       end

       return {
              on = on
              ,off = off
              ,getNeedSwitch = getNeedSwitch
       }
end
