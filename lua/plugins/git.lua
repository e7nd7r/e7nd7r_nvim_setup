return {
    {
        'tpope/vim-fugitive',
        config = function()
        end
    },
    {
        -- Adds git related signs to the gutter, as well as utilities for managing changes
        'lewis6991/gitsigns.nvim',
        config = function ()
            require('gitsigns').setup()

            vim.keymap.set('n', '<leader>hp', ':Gitsigns preview_hunk<CR>', { noremap = true, silent = true })
            vim.keymap.set('n', '[c', ':Gitsigns prev_hunk<CR>', { noremap = true, silent = true })
            vim.keymap.set('n', ']c', ':Gitsigns next_hunk<CR>', { noremap = true, silent = true })
            vim.keymap.set('n', '<leader>hs', ':Gitsigns stage_hunk<CR>', { noremap = true, silent = true })
            vim.keymap.set('n', '<leader>hu', ':Gitsigns undo_stage_hunk<CR>', { noremap = true, silent = true })
            vim.keymap.set('n', '<leader>hr', ':Gitsigns reset_hunk<CR>', { noremap = true, silent = true })
        end,
        opts = {
            signs = {
                add = { text = '+' },
                change = { text = '~' },
                delete = { text = '_' },
                topdelete = { text = '‾' },
                changedelete = { text = '~' },
            },
        },
    },
}
