require("config")
require("keymaps")

-- Setup Lazy.nvim
require("lazy").setup("plugins", {
	performance = {
		rtp = {
			disabled_plugins = {},
		},
	},
	profiling = {
		loader = true,
	},
})
