local M = {
    "lewis6991/gitsigns.nvim",
}

function M.config()
    require("gitsigns").setup {
        signs = {
            add = { text = "+" },
            change = { text = "~" },
            delete = { text = "_" },
            topdelete = { text = "‾" },
            changedelete = { text = "~" },
        },
    }
end

return M
