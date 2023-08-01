SET.laststatus = 3

SET.nu = true
SET.relativenumber = true

SET.tabstop = 4
SET.softtabstop = 4
SET.shiftwidth = 4
SET.expandtab = true

SET.smartindent = true
SET.autoindent = true

SET.wrap = false

SET.swapfile = false
SET.backup = false
SET.undodir = os.getenv("HOME") .. "/./undodir"
SET.undofile = true

SET.hlsearch = true
SET.incsearch = true
SET.ignorecase = true

SET.termguicolors = true

SET.scrolloff = 9
SET.sidescrolloff = 999
SET.signcolumn = "yes"
SET.isfname:append("@-@")

SET.updatetime = 50
SET.foldmethod = "manual"

vim.cmd([[
    set iskeyword-=_
    set syntax=on

    set cursorline
        set listchars=tab:>~,nbsp:_,trail:!,leadmultispace:\ \ \ 󰉶
    set list

    set path+=**

    set wildmenu
    set wildchar=<C-n>
    set wildmode=full
    set wildoptions=pum
    set ph=7

    colorscheme quiet
]])
