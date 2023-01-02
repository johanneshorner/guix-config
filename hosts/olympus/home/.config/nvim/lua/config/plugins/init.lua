return {
	"nvim-lua/plenary.nvim",
	"folke/which-key.nvim",
	{
		"danymat/neogen",
		config = {
			snippet_engine = "luasnip",
		},
	},
	{
		"norcalli/nvim-colorizer.lua",
		config = true,
	},
	{
		"nvim-tree/nvim-web-devicons",
		config = {
			default = true,
		},
	},

	{
		"Wansmer/treesj",
		keys = "J",
		config = function()
			require("treesj").setup({ use_default_keymaps = false })
			require("which-key").register({ J = { "<cmd>TSJToggle<cr>", "Split/Join blocks of code" } })
		end,
	},
	{
		"elihunter173/dirbuf.nvim",
		cmd = "Dirbuf",
	},
	{ "nvim-neo-tree/neo-tree.nvim", dependencies = { "MunifTanjim/nui.nvim" } },
	"iamcco/markdown-preview.nvim",
	{
		"windwp/nvim-autopairs",
		config = true,
	},
	{
		lazy = false,
		"eraserhd/parinfer-rust",
		build = "cargo build --release",
	},
}
