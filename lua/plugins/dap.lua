function RunTestAtCursor()
	local dap = require("dap")
	local params = { textDocument = vim.lsp.util.make_text_document_params() }
	local cursor = vim.api.nvim_win_get_cursor(0)
	local line = cursor[1] - 1 -- 0-indexed
	local col = cursor[2]

	vim.lsp.buf_request(0, "textDocument/documentSymbol", params, function(err, result, _, _)
		if err then
			vim.notify("LSP Error: " .. vim.inspect(err), vim.log.levels.ERROR)
			return
		end

		if not result or vim.tbl_isempty(result) then
			vim.notify("No symbols found in document", vim.log.levels.WARN)
			return
		end

		-- Helper to check if a range includes the cursor
		local function is_inside(range)
			return line >= range.start.line
				and line <= range["end"].line
				and (line > range.start.line or col >= range.start.character)
				and (line < range["end"].line or col <= range["end"].character)
		end

		-- Find the symbol containing the cursor
		local function find_symbol(symbols)
			for _, symbol in ipairs(symbols) do
				if symbol.range and is_inside(symbol.range) then
					return symbol
				elseif symbol.children then
					local child = find_symbol(symbol.children)
					if child then
						return child
					end
				end
			end
		end

		local symbol = find_symbol(result)

		if not symbol then
			vim.notify("No method or function found at cursor", vim.log.levels.WARN)
			return
		end

		-- Check if it's a test method
		local function is_test_method(symbol_name)
			return symbol_name:match("test") ~= nil -- Example: Methods with "test" in their name
		end

		if not is_test_method(symbol.name) then
			vim.notify("Not a test method: " .. symbol.name, vim.log.levels.WARN)
			return
		end

		-- Run the test using DAP
		vim.notify("Running test: " .. symbol.name, vim.log.levels.INFO)

		-- Example DAP configuration for Python (replace with your setup)
		dap.run({
			name = "Run test at cursor",
			type = "python",
			request = "launch",
			program = os.getenv("VIRTUAL_ENV") and os.getenv("VIRTUAL_ENV") .. "/bin/pytest"
				or vim.fn.exepath("pytest"),
			args = { "-m", "debugpy.adapter", "-x", "-v", "--durations=10", "--maxfail=1", "${file}::" .. symbol.name }, -- Pass file::test_name to pytest
			console = "integratedTerminal",
		})
	end)
end

return {
	{
		"mfussenegger/nvim-dap",
		dependencies = { "mfussenegger/nvim-dap-python" },
		config = function()
			local dap = require("dap")

			-- Configure Python adapter
			dap.adapters.python = {
				type = "executable",
				command = "python", -- Adjust to 'python3' or the full path to your Python executable
				args = { "-m", "debugpy.adapter" },
			}

			-- Define debugging configurations
			dap.configurations.python = {
				{
					type = "python", -- Adapter type
					request = "launch", -- Can also be 'attach' for remote debugging
					name = "Launch file",
					program = "${file}", -- This will launch the current file
					pythonPath = function()
						-- Use the virtual environment Python if available
						local venv_path = os.getenv("VIRTUAL_ENV")
						if venv_path then
							return venv_path .. "/bin/python"
						else
							return "python" -- Fallback to system Python
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

			-- -- dap.listeners.after.event_terminated["close_non_project_buffers"] = function()
			--     local project_dir = vim.fn.getcwd() -- Get the current working directory
			--     for _, buf in ipairs(vim.api.nvim_list_bufs()) do
			--         local buf_name = vim.api.nvim_buf_get_name(buf)
			--         if buf_name ~= "" and not buf_name:match(project_dir) then
			--             vim.api.nvim_buf_delete(buf, { force = true }) -- Close the buffer
			--         end
			--     end
			-- end

			vim.keymap.set("n", "<F5>", '<Cmd>lua require("dap").continue()<CR>', { noremap = true, silent = true })
			vim.keymap.set("n", "<F10>", '<Cmd>lua require("dap").step_over()<CR>', { noremap = true, silent = true })
			vim.keymap.set("n", "<F11>", '<Cmd>lua require("dap").step_into()<CR>', { noremap = true, silent = true })
			vim.keymap.set("n", "<F12>", '<Cmd>lua require("dap").step_out()<CR>', { noremap = true, silent = true })
			vim.keymap.set(
				"n",
				"<Leader>b",
				'<Cmd>lua require("dap").toggle_breakpoint()<CR>',
				{ noremap = true, silent = true }
			)
			vim.keymap.set(
				"n",
				"<Leader>B",
				'<Cmd>lua require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))<CR>',
				{ noremap = true, silent = true }
			)
			vim.keymap.set(
				"n",
				"<Leader>lp",
				'<Cmd>lua require("dap").set_breakpoint(nil, nil, vim.fn.input("Log point message: "))<CR>',
				{ noremap = true, silent = true }
			)
			vim.keymap.set(
				"n",
				"<Leader>dr",
				'<Cmd>lua require("dap").repl.open()<CR>',
				{ noremap = true, silent = true }
			)
			vim.keymap.set(
				"n",
				"<Leader>dl",
				'<Cmd>lua require("dap").run_last()<CR>',
				{ noremap = true, silent = true }
			)
			-- vim.keymap.set('n', '<Leader>dc', '<Cmd>lua RunTestAtCursor()<CR>', { noremap = true, silent = true })
			vim.keymap.set(
				"n",
				"<Leader>dt",
				'<Cmd>lua require("dap").terminate()<CR>',
				{ noremap = true, silent = true }
			)
			vim.keymap.set("n", "<Leader>dc", dapui.close, { noremap = true, silent = true })
			vim.keymap.set("n", "<Leader>do", dapui.open, { noremap = true, silent = true })
		end,
	},
	{
		"rcarriga/nvim-dap-ui",
		dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
	},
}
