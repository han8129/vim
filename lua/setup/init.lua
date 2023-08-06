require( "setup.packer" )
require( "setup.set" )
require( "setup.remap" )
require( "setup.netrw" )
require( "setup.EventManager" )
require( "setup.highlight" )
require("setup.statusLine")
require("setup.Models.IBus")
require("setup.Controllers.IBusController")
require( "setup.Controllers.WindowModeController" )
require( "setup.EventManager" )

local eventManager = EventManager().new()
local ibus = IBus()
local ibusController = IBusController().new()
local windowMode = WindowMode().getInstance()
local windowModeController = WindowModeController().new()

function R(name)
    require("plenary.reload").reload_module(name)
end

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
        if windowMode.getState() == "off" then
            SetStatusLine()
        end
    end
)

eventManager.subscribe( "BufEnter", SetGitBranch() )

eventManager.subscribe( "CmdLineEnter", function() ibusController.on() end )

eventManager.subscribe( "InsertEnter", function() ibusController.on() end )

eventManager.subscribe( "CmdLineLeave", function() ibusController.off() end )

eventManager.subscribe( "InsertLeave", function() ibusController.off() end )


eventManager.subscribe( "WinEnter"
    ,function() vim.cmd( "setlocal cursorline" ) end
)

eventManager.subscribe( "WinLeave"
    ,function() vim.cmd( "setlocal nocursorline" ) end
)

eventManager.subscribe( "InsertEnter"
    ,function()
        if windowMode.getState() == windowMode.getDefault().on then
            windowModeController.toggle()
        end
    end
)

eventManager.subscribe( "WinEnter"
    ,function () windowModeController.specificFiles() end
)

eventManager.notify( "ModeChanged" )
eventManager.notify( "InsertEnter" )
eventManager.notify( "InsertLeave" )
eventManager.notify( "CmdLineEnter" )
eventManager.notify( "CmdLineLeave" )
eventManager.notify( "BufEnter" )
eventManager.notify( "WinEnter" )
eventManager.notify( "WinLeave" )
