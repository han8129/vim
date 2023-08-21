require("setup.statusLine")
local expr = { expr = true, noremap = true }

-- Window mode
--
-- Switch focus, close, resize window with out prefix
-- Toggle by <C-w>, Go back to normal mode with <Esc>
local this = {
       default = {on = true, off = false}
}
this.__index = this
this.state = this.default.off

function WindowMode()
       local function getState()
              return this.state
       end

       local function getDefault()
              local clone = {}

              for key, value in pairs(this.default) do
                     clone[key] = value
              end

              return clone
       end

       local function validateState( state )
              for _, value in pairs(this.default) do
                     if state == value then
                            return true
                     end
              end

              return false
       end

       local function setState( newState )
              if validateState ( newState ) == false then
                     return false
              end

              this.state = newState
              return true
       end

       local function remap(key, customKey)
              REMAP("n", key
                     ,function()
                            if this.state == this.default.off then
                                   return key
                            end

                            if customKey then
                                   return "<C-w>" .. customKey
                            end

                            return "<C-w>" .. key
                     end
              , expr)
       end

       return setmetatable({
              getState = getState
              ,setState = setState
              ,getDefault = getDefault
              ,remap = remap
       }, this )
end
