local M = {
    "nvim-lualine/lualine.nvim",
}

function M.config()
    require("lualine").setup({
        options = {
            icons_enabled = false,
            component_separators = "|",
            section_separators = "",
        },
    })
end

return M
