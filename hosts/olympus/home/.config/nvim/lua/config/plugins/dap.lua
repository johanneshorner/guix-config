local M = {
    "mfussenegger/nvim-dap",
    dependencies = {
        { "rcarriga/nvim-dap-ui" },
        { "theHamsta/nvim-dap-virtual-text" },
        { "nvim-telescope/telescope-dap.nvim" }
    },
}

function M.config()
    local dap = require("dap")

    local util = require("config.util")
    util.safe_load("dapui", "setup")
    util.safe_load("nvim-dap-virtual-text", "setup", {})

    dap.configurations.rust = {
        {
            name = "Launch File",
            type = "codelldb",
            request = "launch",
            program = function()
                return vim.fn.input({ "Path to executable: ", vim.fn.getcwd() .. "/", "file" })
            end,
            cwd = "${workspaceFolder}",
            stopOnEntry = false,
        },
    }

    dap.configurations.zig = {
        {
            name = "Launch File",
            type = "codelldb",
            request = "launch",
            program = function()
                return vim.fn.input({ "Path to executable: ", vim.fn.getcwd() .. "/", "file" })
            end,
            cwd = "${workspaceFolder}",
            stopOnEntry = false,
        },
    }

    dap.adapters.codelldb = {
        type = "server",
        port = "${port}",
        executable = {
            command = "codelldb",
            args = { "--port", "${port}" },
        },
    }

    local keymaps = {
        ["<leader>"] = {
            d = {
                name = "+debugging",
                c = { dap.continue, "Continue" },
                b = { dap.toggle_breakpoint, "Toggle breakpoint" },
                s = { dap.step_over, "Step over" },
                S = { dap.step_into, "Step into" },
                r = { dap.repl.open, "Open repl" },
                i = { require("dapui").open, "Open ui" },
            },
        },
    }

    require("which-key").register(keymaps)
end

return M
