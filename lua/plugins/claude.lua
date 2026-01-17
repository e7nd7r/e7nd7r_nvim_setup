return {
	dir = "/Users/esteban/repos/claudecode.nvim",
	name = "claudecode.nvim",
	lazy = false, -- Load on startup for Claude Code integration
	keys = {
		{ "<leader>aa", "<cmd>ClaudeCodeDiffAccept<cr>", desc = "Accept diff" },
		{ "<leader>ad", "<cmd>ClaudeCodeDiffDeny<cr>", desc = "Deny diff" },
	},
	opts = {
		terminal = {
			provider = "none", -- no UI actions; server + tools remain available
		},
		diff_opts = {
			auto_close_on_accept = true,
			open_in_new_tab = true,
		},
	},
}
