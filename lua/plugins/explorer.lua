return {
  "nvim-tree/nvim-tree.lua",
  version = "*",
  lazy = false,
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  config = function()

    require("nvim-tree").setup {
        sync_root_with_cwd = true,
        update_focused_file = {
            enable = true,
            update_cwd = true,
        },
        -- Optional: Respect per-buffer local directories.
        respect_buf_cwd = true,
        git = {
            enable = true,
            ignore = true,
        },
        renderer = {
            highlight_git = true,
            icons = {
                show = {
                    git = true,
                }
            }
        }
    }

    local api = require("nvim-tree.api")

    api.events.subscribe("TreeOpen", function ()
       vim.g.tree_opened = true
    end)

    api.events.subscribe("TreeClose", function ()
       vim.g.tree_opened = false
    end)

    -- Keymaps
    vim.api.nvim_set_keymap('n', '<leader>tt', ':NvimTreeToggle<CR>', { noremap = true, silent = true })

  end,
}
