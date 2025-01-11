local toml = require("toml")
local nio = require("nio")

local cached_config = nil

local function is_match(base_name, pattern)
    local lua_pattern = pattern:gsub("%%", "%%%%"):gsub("%*", ".*"):gsub("%?", ".") -- Convert glob to Lua pattern

    return base_name:match(lua_pattern) ~= nil
end

local function get_config()
    if cached_config then
        return cached_config
    end

    local file, err = nio.file.open(vim.fn.getcwd() .. '/' .. 'pyproject.toml')

    if not file or err then
        return nil
    end

    local content = file.read(nil, 0)

    cached_config = toml.decode(content)

    return cached_config
end

local function get_pytest_config()
    local config = get_config()

    if config and config.tool and config.tool.pytest and config.tool.pytest.ini_options then
        return config.tool.pytest.ini_options
    end

    return nil
end

-- @async
local function is_test_file2(file_path)
    if not vim.endswith(file_path, ".py") then
        return false
    end

    local pytest_config = get_pytest_config()
    local test_patterns = { "test_*.py", "*_test.py" } -- Default patterns

    -- If pytest configuration is found, override test_patterns
    if pytest_config and pytest_config.python_files then
        -- Handle both single string and list of patterns
        if type(pytest_config.python_files) == "string" then
            test_patterns = { pytest_config.python_files }
        elseif type(pytest_config.python_files) == "table" then
            test_patterns = pytest_config.python_files
        end
    end

    -- Check if the file matches any test pattern
    local base_name = file_path:match("^.+/(.+)$")

    for _, pattern in ipairs(test_patterns) do
        if is_match(base_name, pattern) then
            return true
        end
    end

    return false
end

return {
    "nvim-neotest/neotest",
    version = "~5.6.0",
    dependencies = {
        "nvim-neotest/nvim-nio",
        "nvim-lua/plenary.nvim",
        "antoinemadec/FixCursorHold.nvim",
        "nvim-treesitter/nvim-treesitter",
        "nvim-neotest/neotest-python",
        "nvim-neotest/neotest-plenary",
        "nvim-neotest/neotest-vim-test",
        "nvim-treesitter/nvim-treesitter",
        "LebJe/toml.lua",
    },
    config = function ()
        require("neotest").setup {
            adapters = {
                require("neotest-python") {
                    runner = "pytest",
                    dap = { justMyCode = true },
                    args = { "-s", "--log-level", "DEBUG" },
                    is_test_file = function (test_file)
                        nio.scheduler()
                        return is_test_file2(test_file)
                    end
                },
                require("neotest-plenary"),
                require("neotest-vim-test") {
                    ignore_file_types = { "python", "vim", "lua" },
                },
            },
        }

        vim.keymap.set('n', '<leader>td', function()

            if not vim.g.is_test_output_open then
                require('neotest').output_panel.open()
                vim.g.is_test_output_open = true
            end

            require('neotest').run.run({ strategy = "dap" }) -- Debug nearest test
        end, { desc = "Debug nearest test" })

        vim.keymap.set('n', '<leader>tf', function()
            require('neotest').output_panel.open()
            vim.g.is_test_output_open = true

            require('neotest').run.run(vim.fn.expand("%")) -- Run all tests in the current file
        end, { desc = "Run all tests in file" })

        vim.keymap.set('n', '<leader>ts', function()
            require('neotest').summary.toggle() -- Toggle test summary
        end, { desc = "Toggle test summary" })

        vim.keymap.set('n', '<leader>to', function()
            if vim.g.is_test_output_open then
                require('neotest').output_panel.close()
                vim.g.is_test_output_open = false
            else
                require('neotest').output_panel.open()
                vim.g.is_test_output_open = true

            end
        end, { desc = "Toggle [t]est [o]utput" })
   end
}
