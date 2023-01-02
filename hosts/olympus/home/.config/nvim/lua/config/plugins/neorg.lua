local M = {
	lazy = false,
	"nvim-neorg/neorg",
	build = "<cmd>Neorg sync-parsers",
}

function M.config()
	require("neorg").setup({
		load = {
			["core.defaults"] = {},
			["core.keybinds"] = {
				config = {
					default_keybinds = true,
					neorg_leader = "<leader>o",
					hook = function(kb)
						kb.map_event_to_mode("norg", {
							n = { -- Bind keys in normal mode
								{ "<C-s>", "coreintegrations.telescope.find_linkable" },
							},

							i = { -- Bind in insert mode
								{ "<C-l>", "core.integrations.telescope.insert_link" },
							},
						}, {
							silent = true,
							noremap = true,
						})
					end,
				},
			},
			["core.norg.dirman"] = {
				config = {
					workspaces = {
						main = vim.env.HOME .. "/notes",
					},
					autochdir = true,
					default_workspace = "main",
					open_last_workspace = true,
				},
			},
			["core.norg.journal"] = {
				config = {
					workspace = "main",
					strategy = "flat",
				},
			},
			-- ["core.gtd.base"] = {
			-- 	config = {
			-- 		workspace = "main",
			-- 	},
			-- },
			["core.norg.concealer"] = {},
			["core.norg.completion"] = {
				config = {
					engine = "nvim-cmp",
				},
			},
			["core.integrations.nvim-cmp"] = {},
			["core.export"] = {},
			["core.export.markdown"] = {
				config = {
					extensions = "all",
				},
			},
			-- ["core.integrations.telescope"] = {},
		},
	})
end

return M
