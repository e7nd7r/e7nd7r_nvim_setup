require("config")

local plugin_path = vim.fn.stdpath("config") .. "/lua/plugins/"
local plugin_files = vim.fn.glob(plugin_path .. "*.lua", true, true)

-- Setup Lazy.nvim
require("lazy").setup("plugins")

