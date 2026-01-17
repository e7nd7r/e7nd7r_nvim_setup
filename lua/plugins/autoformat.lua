return {
	{
		"stevearc/conform.nvim",
		config = function()
			require("conform").setup({
				formatters_by_ft = {
					python = { "black" },
					lua = { "stylua" },
					typescript = { "prettier" },
					dart = { "dart_format" },
					go = { "gofmt" },
					rust = { "rustfmt" },
					terraform = { "terraform" },
					-- php = { "php-cs-fixer" },
					sh = { "shfmt" },
					bash = { "shfmt" },
					zsh = { "shfmt" },
					yml = { "yamlfmt" },
					yaml = { "yamlfmt" },
				},
				format_on_save = {
					timeout_ms = 60000,
					lsp_fallback = true,
				},
			})
		end,
	},
	{
		"nvimtools/none-ls.nvim",
		config = function()
			local null_ls = require("null-ls")

			require("null-ls").setup({
				sources = {
					null_ls.builtins.formatting.black, -- Python Formatting Rules
					null_ls.builtins.formatting.prettier, -- JS/TS
					null_ls.builtins.formatting.stylua, -- Lua
					null_ls.builtins.formatting.dart_format, -- Dart
					null_ls.builtins.formatting.gofmt, -- Go
					-- null_ls.builtins.formatting.rustfmt, -- Rust

					-- Linters
					-- null_ls.builtins.diagnostics.ruff, -- Python Linter
					-- null_ls.builtins.diagnostics.eslint_d, -- JS/TS Linter
					-- null_ls.builtins.diagnostics.luacheck, -- Lua Linter
					-- null_ls.builtins.diagnostics.golangci_lint, -- Go Linter
				},
			})
		end,
	},
}
