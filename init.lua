require("config")

local plugin_path = vim.fn.stdpath("config") .. "/lua/plugins/"
local plugin_files = vim.fn.glob(plugin_path .. "*.lua", true, true)

-- Setup Lazy.nvim
local plugins = {}

-- Load each plugin file
for _, file in ipairs(plugin_files) do
   local plugin_spec = dofile(file)
   if type(plugin_spec) == "table" then
      vim.list_extend(plugins, plugin_spec)
   end
end

-- Setup Lazy.nvim
require("lazy").setup("plugins")

