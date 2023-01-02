local M = {
    "nvim-neo-tree/neo-tree.nvim"
}

function M.config()
vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])

vim.keymap.set("n", "<Leader>e", "<cmd>Neotree<CR>")
end

return M
