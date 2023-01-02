local M = {
	lazy = false,
	"akinsho/bufferline.nvim",
}

function M.config()
	require("bufferline").setup()
end

return M
