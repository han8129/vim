require( "setup.Models.WindowMode" )
require( "setup.Controllers.WindowModeController" )
require( "setup.Models.Netrw" )
require( "setup.Controllers.NetrwController" )

local expr = { expr = true, noremap = true }
local windowMode = WindowMode().getInstance()
local windowModeController = WindowModeController().new()

local netrw = Netrw().getInstance()
local netrwController = NetrwController().new()

vim.g.mapleader = " "

REMAP("n", "U", "<C-r>")

REMAP( {'n', 'v'}, ':', ';')
REMAP( {'n', 'v'}, ';', ':')

REMAP(
    { "v", "o" }
    , "-", "^"
)

REMAP("n", "G", "Gzz")

REMAP("n", "<C-q>", "v")

REMAP("v", "<BS>", "x")
REMAP("v", "aa", "VGo1G")

REMAP("v", "J", ":m '>+1<CR>gv=gv")
REMAP("v", "K", ":m '<-2<CR>gv=gv")

-- Steve Matney
REMAP("v", "L", ">gv")
REMAP("v", "H", "<gv")

REMAP("n", "<C-d>", "<C-d>zz")
REMAP("n", "<C-u>", "<C-u>zz")
REMAP("n", "n", "nzzzv")
REMAP("n", "N", "Nzzzv")

-- greatest remap ever
REMAP("x", "<leader>p", [["_dP]])

-- next greatest remap ever : asbjornHaland
REMAP({ "n", "v" }, "<leader>y", [["+y]])
REMAP("n", "<leader>Y", [["+Y]])

REMAP({ "n", "v" }, "<leader>d", [["_d]])

REMAP("n", "Q", "<nop>")
REMAP("n", "<leader>fm", vim.lsp.buf.format)

REMAP("n", "<C-k>", "<cmd>cnext<CR>zz")
REMAP("n", "<C-j>", "<cmd>cprev<CR>zz")
REMAP("n", "<leader>k", "<cmd>lnext<CR>zz")
REMAP("n", "<leader>j", "<cmd>lprev<CR>zz")

REMAP("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

REMAP("n", "<leader>mr", "<cmd>CellularAutomaton make_it_rain<CR>")

REMAP("n", "<leader><leader>", function()
    vim.cmd("so %")
end)

REMAP("n", "<C-w>"
, function()
    if windowMode.getState() == windowMode.getDefault().on then
        return "<C-w>"
    end

    windowModeController.on()
end
, expr)

-- Window mode remap
REMAP("n", "<Esc>"
, function()
    if windowMode.getState() == windowMode.getDefault().off then
        return "<cmd>nohls<Enter>"
    end

    windowModeController.off()
end
, expr)

REMAP("n", "v"
, function()
    if windowMode.getState() == windowMode.getDefault().on then
        return "<C-w>v"
    end

    return "<C-q>"
end
, expr)


REMAP("n", "J"
, function()
    if windowMode.getState() == windowMode.getDefault().on then
        return "<C-w>J"
    end

    return "mzJ`z"
end
, expr)

REMAP("n", "K"
, function()
    if windowMode.getState() == windowMode.getDefault().on then
        return "<cmd>wincmd K<Enter>"
    end

    return '<CMD>lua _G.show_docs()<CR>'
end
, expr)

REMAP("n", "o"
, function()
    if windowMode.getState() == windowMode.getDefault().on then
        windowModeController.off()

        return "<C-w>o"
    end

    return "o"
end
, expr)

REMAP("n", "-"
, function()
    if windowMode.getState() == windowMode.getDefault().on then
        return "<C-w>5-"
    end

    return "^"
end
, expr)

windowMode.remap("H")

windowMode.remap("L")

windowMode.remap("s")

windowMode.remap("h")

windowMode.remap("j")

windowMode.remap("k")

windowMode.remap("l")

windowMode.remap("x", "c")

windowMode.remap( "=", "5+" )

windowMode.remap( "+", "=" )

windowMode.remap( "0", "10>")

windowMode.remap( "9", "10<")

REMAP("n", "<leader>ff"
, function()
    if netrw.getState() == netrw.getDefault().on then
        if netrwController.close() then
        return "<cmd>Lex<Enter>"
        end
    end

    netrwController.resize()
    return "<cmd>Lex%:p:h<Enter>"
end
, expr)
