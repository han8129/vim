require( "setup.packer" )
require( "setup.set" )
require( "setup.remap" )
require( "setup.Models.Netrw" )
require( "setup.EventManager" )
require( "setup.highlight" )
require("setup.statusLine")
require("setup.Models.IBus")
require("setup.Controllers.IBusController")
require( "setup.Controllers.WindowModeController" )
require( "setup.Controllers.NetrwController" )
require( "setup.EventManager" )

local eventManager = EventManager().new()

local ibus = IBus()
local ibusController = IBusController().new()

local windowMode = WindowMode().getInstance()
local windowModeController = WindowModeController().new()

local netrw = Netrw().getInstance()
local netrwController = NetrwController().new()

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

eventManager.subscribe( "BufEnter" , function()
    SetGitBranch()
end)

eventManager.subscribe( "FileType" , function()
    if "netrw" == vim.bo.ft then
        netrw.map()
        netrw.setState( netrw.getDefault().on )
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
