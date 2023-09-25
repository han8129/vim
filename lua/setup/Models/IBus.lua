local this = {}
this.__index = this
this._languages = { EN = "BambooUs", VI = "Bamboo"}

function IBus()
       local function getLanguage()
              local currentLanguage = vim.fn.system('ibus engine')

              -- the return value contain newline character
              return string.sub(currentLanguage, 1, -2)
       end

       local function setLanguage( language )
              for _, value in pairs( this._languages ) do
                     if value == language then
                            vim.fn.system( 'ibus engine ' .. value )
                            return true
                     end
              end

              return false
       end

       local function getDefault()
              local clone = {}

              for key, value in pairs(this._languages) do
                     clone[key] = value
              end

              return clone
       end

       return setmetatable({
              getLanguage = getLanguage
              ,setLanguage = setLanguage
              ,getDefault = getDefault
       }, this)
end
