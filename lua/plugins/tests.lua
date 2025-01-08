local function get_pytest_config()
    local toml = require("toml")

    local file, err = io.open(vim.fn.getcwd() .. '/' .. 'pyproject.toml')

    -- vim.notify(file and 'pyproject found' or 'pyproject not found')

    if not file or err then
        return nil
    end

    -- Parse pyproject.toml
    local file_content = file:read("*all")

    -- if file_content then
        -- vim.notify("content was load")
    -- end

    local config = toml.decode(file_content)
    if not config then
        return nil
    end

    -- vim.notify('config loaded')

    if config.tool and config.tool.pytest and config.tool.pytest.ini_options then
        return config.tool.pytest.ini_options
    end

    return nil
end

local function is_test_file2(file_path)
    if not vim.endswith(file_path, ".py") then
        return false
    end

    local pytest_config = get_pytest_config()
    local test_patterns = { "test_*.py", "*_test.py" } -- Default patterns

    -- If pytest configuration is found, override test_patterns
    if pytest_config and pytest_config.python_files then

        -- vim.notify('loading patterns')
        -- vim.notify('pyproject python_files' .. pytest_config.python_files)

        -- Handle both single string and list of patterns
        if type(pytest_config.python_files) == "string" then
            test_patterns = { pytest_config.python_files }
        elseif type(pytest_config.python_files) == "table" then
            test_patterns = pytest_config.python_files
        end
    end

    -- Check if the file matches any test pattern
    local base_name = file_path:match("^.+/(.+)$")

    -- vim.notify("Base name:" .. base_name)

    for _, pattern in ipairs(test_patterns) do
        -- vim.notify("checking pattern:" .. pattern)

        local a = vim.fn.match(base_name, vim.fn.glob2regpat(pattern))

        -- vim.notify("match result:" .. tostring(a))

        if vim.fn.match(base_name, vim.fn.glob2regpat(pattern)) ~= -1 then
            -- TODO: Investigatin async issue.
            -- https://github.com/nvim-neotest/neotest/issues/444
            return true
        end
    end

    print("end. ... ")

    return true
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
                    dap = { justMyCode = false },
                    args = { "--log-level", "DEBUG" },
                    is_test_file = function (test_file)
                       local a = is_test_file2(test_file)
                       return a
                    end
                },
                require("neotest-plenary"),
                require("neotest-vim-test") {
                    ignore_file_types = { "python", "vim", "lua" },
                },
            },
        }

        vim.keymap.set('n', '<leader>td', function()
            require('neotest').run.run({ strategy = "dap" }) -- Debug nearest test
        end, { desc = "Debug nearest test" })

        vim.keymap.set('n', '<leader>tf', function()
            require('neotest').run.run(vim.fn.expand("%")) -- Run all tests in the current file
        end, { desc = "Run all tests in file" })

        vim.keymap.set('n', '<leader>ts', function()
            require('neotest').summary.toggle() -- Toggle test summary
        end, { desc = "Toggle test summary" })

        vim.keymap.set('n', '<leader>to', function()
            require('neotest').output.open({ enter = true }) -- Open test output
        end, { desc = "Open test output" })
    end
}
