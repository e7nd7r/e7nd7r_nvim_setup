require('plugins')

-- Treesitter highlight syntax configuration
require('nvim-treesitter.configs').setup {
  ensure_installed = { "lua", "javascript", "html", "css" }, -- Add desired languages
  sync_install = false, -- Install languages synchronously
  auto_install = true, -- Automatically install missing parsers
  highlight = {
    enable = true, -- Enable syntax highlighting
    additional_vim_regex_highlighting = false, -- Disable Vim regex highlighting
  },
}

-- Theme Configuration
vim.cmd[[colorscheme nord]]

-- Telescope (Filemanager configuration)
vim.api.nvim_set_keymap('n', '<leader>ff', "<cmd>lua require('telescope.builtin').find_files()<CR>", { noremap = true, silent = true })
vim.opt.termguicolors = true

-- Bufferline Configurations
require("bufferline").setup {
    options = {
    	show_buffer_icons = true,
	show_buffer_close_icons = true,
	separator_style = "slant",
    }
}

vim.api.nvim_set_keymap('n', '<Tab>', ':BufferLineCycleNext<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<S-Tab>', ':BufferLineCyclePrev<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>bn', ':BufferLineMoveNext<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>bp', ':BufferLineMovePrev<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>bc', ':BufferLinePickClose<CR>', { noremap = true, silent = true })

-- Line number configuration 
vim.opt.number = true
vim.opt.relativenumber = true

-- Language Server Protocol Configuration

local lspconfig = require('lspconfig')

lspconfig.pyright.setup {}

local on_attach = function(client, bufnr)
  local opts = { noremap=true, silent=true }
  local buf_set_keymap = vim.api.nvim_buf_set_keymap

  -- Keybindings
  buf_set_keymap(bufnr, 'n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap(bufnr, 'n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap(bufnr, 'n', 'gi', '<Cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap(bufnr, 'n', '<C-k>', '<Cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
end

lspconfig.pyright.setup { on_attach = on_attach }

require("mason").setup()
require("mason-lspconfig").setup({
  ensure_installed = { "pyright" }, -- Automatically install pyright
})

-- Debugger
local dap = require('dap')

-- Configure Python adapter
dap.adapters.python = {
  type = 'executable',
  command = 'python3.11', -- Adjust to 'python3' or the full path to your Python executable
  args = { '-m', 'debugpy.adapter' },
}

-- Define debugging configurations
dap.configurations.python = {
  {
    type = 'python',    -- Adapter type
    request = 'launch', -- Can also be 'attach' for remote debugging
    name = "Launch file",
    program = "${file}", -- This will launch the current file
    pythonPath = function()
      -- Use the virtual environment Python if available
      local venv_path = os.getenv("VIRTUAL_ENV")
      if venv_path then
        return venv_path .. "/bin/python3.11"
      else
        return "python3.11" -- Fallback to system Python
      end
    end,
  },
}

local dapui = require("dapui")

dapui.setup()

-- Automatically open/close the UI when debugging starts/stops
dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close()
end

require("nvim-dap-virtual-text").setup()

vim.keymap.set('n', '<F5>', function() dap.continue() end)
vim.keymap.set('n', '<F10>', function() dap.step_over() end)
vim.keymap.set('n', '<F11>', function() dap.step_into() end)
vim.keymap.set('n', '<F12>', function() dap.step_out() end)
vim.keymap.set('n', '<Leader>b', function() dap.toggle_breakpoint() end)
vim.keymap.set('n', '<Leader>B', function() dap.set_breakpoint(vim.fn.input('Breakpoint condition: ')) end)
vim.keymap.set('n', '<Leader>lp', function() dap.set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end)
vim.keymap.set('n', '<Leader>dr', function() dap.repl.open() end)
vim.keymap.set('n', '<Leader>dl', function() dap.run_last() end)
vim.keymap.set('n', '<Leader>dc', function() dap.terminate() end)

-- Disable arrow keys in normal mode
vim.api.nvim_set_keymap('n', '<Up>', '', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Down>', '', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Left>', '', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Right>', '', { noremap = true, silent = true })

-- Disable arrow keys in insert mode
vim.api.nvim_set_keymap('i', '<Up>', '', { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', '<Down>', '', { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', '<Left>', '', { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', '<Right>', '', { noremap = true, silent = true })

-- Disable arrow keys in visual mode
vim.api.nvim_set_keymap('v', '<Up>', '', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<Down>', '', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<Left>', '', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<Right>', '', { noremap = true, silent = true })

vim.opt.tabstop = 4 
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.softtabstop = 4

-- GitSigns
require('gitsigns').setup()

vim.api.nvim_set_keymap('n', '<leader>hp', ':Gitsigns preview_hunk<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '[c', ':Gitsigns prev_hunk<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', ']c', ':Gitsigns next_hunk<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>hs', ':Gitsigns stage_hunk<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>hu', ':Gitsigns undo_stage_hunk<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>hr', ':Gitsigns reset_hunk<CR>', { noremap = true, silent = true })

require('nvim-tree').setup({
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
})

vim.api.nvim_set_keymap('n', '<leader>tt', ':NvimTreeToggle<CR>', { noremap = true, silent = true })

