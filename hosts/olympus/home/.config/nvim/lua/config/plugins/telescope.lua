local M = {
	"nvim-telescope/telescope.nvim",
	lazy = false,
	dependencies = {
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		"nvim-telescope/telescope-file-browser.nvim",
		"nvim-telescope/telescope-ui-select.nvim",
		"nvim-telescope/telescope-symbols.nvim",
		"MrcJkb/telescope-manix",
	},
}

local function project_files(opts)
	opts = opts or {}
	opts.show_untracked = true
	if vim.loop.fs_stat(".git") then
		require("telescope.builtin").git_files(opts)
	else
		local client = vim.lsp.get_active_clients()[1]
		if client then
			opts.cwd = client.config.root_dir
		end
		require("telescope.builtin").find_files(opts)
	end
end

function M.config()
	local telescope = require("telescope")

	telescope.setup({
		defaults = {
			mappings = {
				i = {
					["<C-h>"] = "which_key",
				},
			},
		},
		pickers = {
			find_files = {
				find_command = { "rg", "--ignore", "-L", "--hidden", "--files" },
			},
		},
	})

	telescope.load_extension("fzf")
	telescope.load_extension("file_browser")
	telescope.load_extension("manix")
	telescope.load_extension("ui-select")

	local tb = require("telescope.builtin")
	local util = require("config.util")
	local th = require("telescope.themes")

	local function theme(params)
		-- return th.get_ivy(params)
		return params
	end

	local keymaps = {
		["<leader>"] = {
			["ä"] = {
				util.bind(tb.current_buffer_fuzzy_find, theme({ winblend = 10, previewer = false })),
				"Current buffer fuzzy search",
			},
			s = {
				name = "+Search",
				g = { util.bind(tb.live_grep, theme({})), "Grep in current cwd" },
				o = { util.bind(tb.live_grep, theme({ cwd = vim.fn.expand("~/notes") })), "Grep in notes" },
				f = { util.bind(project_files, theme({})), "Search files" },
				e = { util.bind(telescope.extensions.file_browser.file_browser, theme({})), "Browse Cwd" },
				h = { util.bind(tb.help_tags, theme({})), "Search nvim help tags" },
				w = { util.bind(tb.grep_string, theme({})), "Grep word under cursor" },
				d = { util.bind(tb.diagnostics, theme({})), "Search diagnostics" },
				nix = { util.bind(require("telescope-manix").search, theme({})), "Search nix options" },
				c = { util.bind(tb.commands, theme({})), "Search user commands", mode = { "n", "v" } },
			},
			["<leader>"] = { util.bind(tb.buffers, theme({})), "Find existing buffers" },
			["-"] = { util.bind(tb.oldfiles, theme({})), "Find recently opened files" },
			["f<leader>"] = {
				util.bind(
					tb.find_files,
					theme({
						prompt_title = "nvim",
						cwd = vim.fn.expand("~/.config/nvim"),
					})
				),
				"Search nvim config",
			},
		},
	}

	require("which-key").register(keymaps)
end

return M
