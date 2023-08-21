-- require( "setup.packer" )
require( "setup.set" )
require( "setup.remap" )
require( "setup.Models.Netrw" )
require( "setup.EventManager" )
require( "setup.highlight" )
require("setup.statusLine")
require("setup.Models.IBus")
require("setup.Controllers.IBusController")
require( "setup.Controllers.WindowModeController" )
require( "setup.EventManager" )

local eventManager = EventManager()

local ibus = IBus()
local ibusController = IBusController( ibus )

local windowMode = WindowMode()
local windowModeController = WindowModeController( windowMode )

local netrw = Netrw()

local ThePrimeagenGroup = AUTOCMD_GROUP('ThePrimeagen', {})

local yank_group = AUTOCMD_GROUP('HighlightYank', {})

AUTOCMD('TextYankPost', {
       group = yank_group,
       pattern = '*',
       callback = function()
              vim.highlight.on_yank({
                     higroup = 'IncSearch',
                     timeout = 40,
              })
       end,
})

AUTOCMD({"BufWritePre"}, {
       group = ThePrimeagenGroup,
       pattern = "*",
       command = [[%s/\s\+$//e]],
})

-- turn off Ibus when entering vim
ibus.setLanguage( ibus.getDefault().EN )

eventManager.subscribe( "ModeChanged",
function()
       if windowMode.getState() == windowMode.getDefault().off then
              SetStatusLine()
       end
end
)

eventManager.subscribe( "BufEnter" , function()
       SetGitBranch()
end)

eventManager.subscribe( "FileType" , function()
       if "netrw" == vim.bo.ft then
              netrw.map()
       end
end)

eventManager.subscribe( "CmdLineEnter", function() ibusController.on() end )

eventManager.subscribe( "CmdLineLeave", function() ibusController.off() end )

eventManager.subscribe( "InsertLeave", function() ibusController.off() end )

eventManager.subscribe( "WinLeave"
,function() vim.cmd( "setlocal nocursorline" ) end
)

eventManager.subscribe( "InsertEnter"
,function()
       windowModeController.off()
       ibusController.on()
end
)

eventManager.subscribe( "WinEnter"
,function ()
       windowModeController.specificFiles()
       vim.cmd( "setlocal cursorline" )
end
)
