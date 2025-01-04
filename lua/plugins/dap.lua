return {
    {
        'mfussenegger/nvim-dap',
        config = function ()
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
        end
    },
    {
      'rcarriga/nvim-dap-ui',
      dependencies = { 'mfussenegger/nvim-dap', 'nvim-neotest/nvim-nio' }
    }
}
