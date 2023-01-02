local wk = require("which-key")

vim.o.timeoutlen = 500

wk.setup({
	show_help = false,
	triggers = "auto",
})

local keymaps = {
	[" "] = { "<Nop>", "unbind leader in { n, v }", mode = { "n", "v" } },
	["jk"] = { "<Esc>", "Exit insert mode", mode = { "i" } },

	-- Remap for dealing with word wrap
	k = { "v:count == 0 ? 'gk' : 'k'", "Word wrap help", expr = true },
	j = { "v:count == 0 ? 'gj' : 'j'", "Word wrap help", expr = true },

	-- -- Center view after scrolling
	["<C-d>"] = { "<C-d>zz", "Center view after scrolling" },
	["<C-u>"] = { "<C-u>zz", "Center view after scrolling" },

	-- -- what do those two do
	-- { "n", "nzzzv" },
	-- { "N", "Nzzzv" },

	-- -- Normal --
	-- -- Better window navigation
	["<C-h>"] = { "<C-w>h", "Move one window left" },
	["<C-l>"] = { "<C-w>l", "Move one window right" },
	["<C-j>"] = { "<C-w>j", "Move one window down" },
	["<C-k>"] = { "<C-w>k", "Move one window up" },

	-- -- Resizing
	["<A-K>"] = { ":resize +2<CR>", "Resize upwards" },
	["<A-J>"] = { ":resize -2<CR>", "Resize downwards" },
	["<A-H>"] = { ":vertical resize -2<CR>", "Resize to the left" },
	["<A-L>"] = { ":vertical resize +2<CR>", "Resize to the right" },

	-- -- next/previous buffer
	["<S-l>"] = { ":bnext<CR>", "Next buffer" },
	["<S-h>"] = { ":bprevious<CR>", "Previous buffer" },

	-- -- Visual --
	-- -- Stay in indent mode
	["<"] = { "<gv", "Stay in visual mode when indenting", mode = { "v" } },
	[">"] = { ">gv", "Stay in visual mode when indenting", mode = { "v" } },

	-- -- Move text up and down in visual mode
	["<A-j>"] = {
		{ ":m .+1<CR>==", "Move text one line down", mode = { "v" } },
		{ ":move '>+1<CR>gv-gv", "Move text one line down", mode = { "x" } },
	},
	["<A-k>"] = {
		{ ":m .-2<CR>==", "Move text one line up", mode = { "v" } },
		{ ":move '<-2<CR>gv-gv", "Move text one line up", mode = { "x" } },
	},
}

wk.register(keymaps)
