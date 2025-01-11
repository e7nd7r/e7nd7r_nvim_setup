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
        vim.keymap.set('n', '<Tab>', ':BufferLineCycleNext<CR>', { noremap = true, silent = true })
        -- Go to the previous tab 
        vim.keymap.set('n', '<S-Tab>', ':BufferLineCyclePrev<CR>', { noremap = true, silent = true })
        -- Go to the next tab.
        vim.keymap.set('n', '<leader>bn', ':BufferLineMoveNext<CR>', { noremap = true, silent = true })
        -- Go to previous tab.
        vim.keymap.set('n', '<leader>bp', ':BufferLineMovePrev<CR>', { noremap = true, silent = true })
        -- Pick a tab and close it.
        vim.keymap.set('n', '<leader>bc', ':BufferLinePickClose<CR>', { noremap = true, silent = true })
        -- Close the tabs at the right. 
        vim.keymap.set('n', '<leader>bl', ':BufferLineCloseRight<CR>', { noremap = true, silent = true })
        -- Close the tabs at the left.
        vim.keymap.set('n', '<leader>bh', ':BufferLineCloseLeft<CR>', { noremap = true, silent = true })
        -- Close others
        vim.keymap.set('n', '<leader>bo', ':BufferLineCloseOthers<CR>', { noremap = true, silent = true })
    end
}

