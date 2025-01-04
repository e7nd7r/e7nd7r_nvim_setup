return {
    'akinsho/bufferline.nvim',
    version = "*",
    dependencies = 'nvim-tree/nvim-web-devicons',
    config = function()
        require("bufferline").setup {
            options = {
                show_buffer_icons = true,
                show_buffer_close_icons = true,
                separator_style = "slant",
            }
        }

        -- Go to the next tab
        vim.api.nvim_set_keymap('n', '<Tab>', ':BufferLineCycleNext<CR>', { noremap = true, silent = true })
        -- Go to the previous tab 
        vim.api.nvim_set_keymap('n', '<S-Tab>', ':BufferLineCyclePrev<CR>', { noremap = true, silent = true })
        -- Go to the next tab.
        vim.api.nvim_set_keymap('n', '<leader>bn', ':BufferLineMoveNext<CR>', { noremap = true, silent = true })
        -- Go to previous tab.
        vim.api.nvim_set_keymap('n', '<leader>bp', ':BufferLineMovePrev<CR>', { noremap = true, silent = true })
        -- Pick a tab and close it.
        vim.api.nvim_set_keymap('n', '<leader>bc', ':BufferLinePickClose<CR>', { noremap = true, silent = true })
    end
}
