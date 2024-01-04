return {
    "ThePrimeagen/harpoon"
    ,branch = "harpoon2"
    ,dependencies = "nvim-lua/plenary.nvim"
    ,config = function()
        local harpoon = require("harpoon")
        harpoon:setup({
            setting = {
                save_on_toggle = true
                ,tabline = true
            }
        })
        local list = harpoon:list()

        -- configurations.setup({
        --     save_on_toggle = true,
        --     tabline = true,
        --     tabline_prefix = " ",
        --     tabline_suffix = " "
        -- })

        -- red = "#ff757f"
        -- green = "#ff757f"
        -- local blue = "#7aa2f7"
        --
        -- vim.cmd('highlight! TabLineFill guibg=NONE guifg=gray')
        --
        -- vim.cmd('highlight! HarpoonActive guibg=' .. blue .. ' guifg=black')
        -- vim.cmd('highlight! HarpoonInactive guibg=NONE guifg=gray')
        --
        -- vim.cmd('highlight! HarpoonNumberActive guibg=' .. blue .. ' guifg=black')
        -- vim.cmd('highlight! HarpoonNumberInactive guibg=NONE guifg=gray')

        AUTOCMD_GROUP("harpoon_mapping", {
            clear = true
        })

        AUTOCMD('FileType', {
            pattern = 'harpoon',
            group = 'harpoon_mapping',
            command = "lua HarpoonMenu()"
        })
        --
        -- HarpoonMode = 0

        function HarpoonMenu()

            local bufnr = vim.api.nvim_get_current_buf()
            local opts = { buffer = bufnr, remap = true }

            vim.keymap.set( "n", "J", "v:m '>+1<CR>gv=gv<Esc>", opts );
            vim.keymap.set( "n", "K", "v:m '<-2<CR>gv=gv<Esc>", opts );
            vim.keymap.set( "n", "H", "p", opts );
            vim.keymap.set( "n", "L", "dd", opts );

            REMAP("n", "a", function() list:select(1) end, opts)
            REMAP("n", "e", function() list:select(2) end, opts)
            REMAP("n", "o", function() list:select(3) end, opts)
            REMAP("n", "i", function() list:select(4) end, opts)

        end

        REMAP("n", "<leader>a", function() list:append() end)
        REMAP("n", "<C-e>"
        , function()
            harpoon.ui:toggle_quick_menu(list)
        end)

        REMAP("n", "<Tab>", function() list:next() end)
    end
}
