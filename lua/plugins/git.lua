return {
    {
        "NeogitOrg/neogit",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "sindrets/diffview.nvim",
            "echasnovski/mini.pick",
        },
        config = function()
            require("neogit").setup({
                integrations = {
                    diffview = true
                }
            })
            vim.keymap.set('n', '<leader>gg', ':Neogit<CR>', { desc = 'Open Neogit' })
        end
    },
    {
        'lewis6991/gitsigns.nvim',
        event = { "BufReadPre", "BufNewFile" },
        config = function()
            require('gitsigns').setup({
                signs = {
                    add          = { text = "▎" }, -- nf-oct-diff_added
                    change       = { text = "▎" }, -- nf-oct-diff_modified
                    delete       = { text = "" }, -- nf-fa-minus_square_o
                    topdelete    = { text = "" }, -- nf-fa-minus_square_o
                    changedelete = { text = "▎" }, -- nf-oct-diff_renamed
                    untracked    = { text = "▎" }, -- nf-oct-diff_ignored
                },
                signcolumn = true,
                numhl = false,
                linehl = false,
                word_diff = false,
                watch_gitdir = {
                    follow_files = true
                },
                attach_to_untracked = true,
                current_line_blame = false,
                current_line_blame_opts = {
                    virt_text = true,
                    virt_text_pos = 'eol',
                    delay = 1000,
                    ignore_whitespace = false,
                },
                current_line_blame_formatter = '<author>, <author_time:%Y-%m-%d> - <summary>',
                on_attach = function(bufnr)
                    local gs = package.loaded.gitsigns

                    local function map(mode, l, r, opts)
                        opts = opts or {}
                        opts.buffer = bufnr
                        vim.keymap.set(mode, l, r, opts)
                    end

                    -- Navigation
                    map('n', ']c', function()
                        if vim.wo.diff then return ']c' end
                        vim.schedule(function() gs.next_hunk() end)
                        return '<Ignore>'
                    end, {expr=true, desc = 'Next Hunk'})

                    map('n', '[c', function()
                        if vim.wo.diff then return '[c' end
                        vim.schedule(function() gs.prev_hunk() end)
                        return '<Ignore>'
                    end, {expr=true, desc = 'Prev Hunk'})

                    -- Actions
                    map('n', '<leader>hs', gs.stage_hunk, { desc = 'Stage Hunk' })
                    map('n', '<leader>hr', gs.reset_hunk, { desc = 'Reset Hunk' })
                    map('v', '<leader>hs', function() gs.stage_hunk {vim.fn.line('.'), vim.fn.line('v')} end, { desc = 'Stage Hunk' })
                    map('v', '<leader>hr', function() gs.reset_hunk {vim.fn.line('.'), vim.fn.line('v')} end, { desc = 'Reset Hunk' })
                    map('n', '<leader>hS', gs.stage_buffer, { desc = 'Stage Buffer' })
                    map('n', '<leader>hu', gs.undo_stage_hunk, { desc = 'Undo Stage Hunk' })
                    map('n', '<leader>hR', gs.reset_buffer, { desc = 'Reset Buffer' })
                    map('n', '<leader>hp', gs.preview_hunk, { desc = 'Preview Hunk' })
                    map('n', '<leader>hb', function() gs.blame_line{full=true} end, { desc = 'Blame Line' })
                    map('n', '<leader>tb', gs.toggle_current_line_blame, { desc = 'Toggle Line Blame' })
                    map('n', '<leader>hd', gs.diffthis, { desc = 'Diff This' })
                    map('n', '<leader>hD', function() gs.diffthis('~') end, { desc = 'Diff This ~' })
                    map('n', '<leader>td', gs.toggle_deleted, { desc = 'Toggle Deleted' })
                end
            })
        end
    },
    {
        "akinsho/git-conflict.nvim",
        version = "*",
        config = function()
            require("git-conflict").setup({
                default_mappings = true,
                default_commands = true,
                disable_diagnostics = false,
                highlights = {
                    incoming = 'DiffText',
                    current = 'DiffAdd',
                }
            })
        end
    },
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

