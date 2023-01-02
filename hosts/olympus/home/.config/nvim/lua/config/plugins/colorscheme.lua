local M = {
	"ellisonleao/gruvbox.nvim",
	lazy = false,
}

function M.config()
	vim.opt.background = "dark"

	require("gruvbox").setup({
		transparent_mode = true,
	})

	vim.cmd.colorscheme("gruvbox")
end

return M
