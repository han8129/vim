require( "setup.Models.WindowMode" )

function WindowModeController( windowMode )
       local this = { windowMode = windowMode }
       this.__index = this

       local function on()
              if this.windowMode.getState() == this.windowMode.getDefault().on then
                     return false
              end

              this.windowMode.setState( this.windowMode.getDefault().on )
              SetStatusLine( "w" )
              print( "-- WINDOW --" )

              return true
       end

       local function off()
              if this.windowMode.getState() == this.windowMode.getDefault().off then
                     return false
              end

              this.windowMode.setState( this.windowMode.getDefault().off )
              SetStatusLine()
              print( " " )

              return true
       end

       local function specificFiles()
              if this.windowMode.getState() == this.windowMode.getDefault().off then
                     return
              end

              local pattern = { 'netrw', 'fugitive', 'help' }

              local buffer = vim.bo.ft

              for _, filetype in ipairs(pattern) do
                     if filetype == buffer then
                            this.off()
                            return
                     end
              end
       end

       return {
              on = on
              ,off = off
              ,specificFiles = specificFiles
       }
end
