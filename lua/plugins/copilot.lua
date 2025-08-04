return {
	"github/copilot.vim",
	config = function()
		vim.keymap.set("i", "<C-s>", 'copilot#Accept("\\<CR>")', {
			expr = true,
			replace_keycodes = false,
			desc = "Copilot accept suggestion",
		})

		vim.keymap.set("i", "<C-w>", "<Plug>(copilot-accept-word)", {
			desc = "Copilot accept word",
		})

		vim.keymap.set("i", "<C-l>", "<Plug>(copilot-accept-line)", {
			desc = "Copilot accept line",
		})

		vim.g.copilot_no_tab_map = true
	end,
}
