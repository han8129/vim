require("setup.Models.OnOrOff")

local options = {
       netrw_banner = 0,
       netrw_browse_split = 4,
       netrw_liststyle = 0,
       netrw_preview = 1,
       netrw_altv = 1,
       netrw_localcopydircmd = 'cp -r',
}

-- setup netrw configurations
for key, value in pairs( options ) do
       LET[key] = value
end

local this = {
       default = OnOrOff()
}

this.__index = this
this.state = this.default.off

function Netrw()
       local function getState()
              return this.state
       end

       local function getDefault()
              local clone = {}

              for key, value in pairs( this.default ) do
                     clone[key] = value
              end

              return clone
       end

       local function validateState( state )
              for _, value in pairs( this.default ) do
                     if state == value then
                            return true
                     end
              end

              return false
       end

       local function setState( newState )
              if validateState( newState ) == false then
                     return false
              end

              this.state = newState
              return true
       end

       local function map()
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
              getDefault = getDefault
              ,getState = getState
              ,setState = setState
              ,map = map
       }
end
