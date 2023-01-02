local M = {
    "L3MON4D3/LuaSnip",

    dependencies = {
        {
            "rafamadriz/friendly-snippets",
            config = function()
                require("luasnip.loaders.from_vscode").lazy_load()
            end,
        }
    },
}

function M.config()
    require("neogen")

    require("luasnip").config.setup({
        history = true,
        enable_autosnippets = true,
    })
end

return M
