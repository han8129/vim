vim.g.mapleader = " "

REMAP("n", "U", "<C-r>")

REMAP( {'n', 'v'}, ':', ';')
REMAP( {'n', 'v'}, ';', ':')

REMAP(
    { "n", "v" }
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

REMAP("n", "<leader>zt", "vitzf")
REMAP("n", "<leader>z(", "vi(zf")
REMAP("n", "<leader>z[", "vi[zf")
REMAP("n", "<leader>z{", "vi{zf")

REMAP("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

REMAP("n", "<leader>mr", "<cmd>CellularAutomaton make_it_rain<CR>")

REMAP("n", "<leader><leader>", function()
    vim.cmd("so %")
end)
