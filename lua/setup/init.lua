require("setup.packer")
require("setup.set")
require("setup.remap")
require("setup.netrw")
require("setup.autoswap")
require("setup.statusLine")
require("setup.windowMode")
require("setup.ibus")
require("setup.highlight")
-- require("setup.indentation")

local ThePrimeagenGroup = AUTOCMD_GROUP('ThePrimeagen', {})

local yank_group = AUTOCMD_GROUP('HighlightYank', {})

function R(name)
    require("plenary.reload").reload_module(name)
end

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

