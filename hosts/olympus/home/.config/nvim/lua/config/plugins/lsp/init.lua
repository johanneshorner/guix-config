local M = {
	"neovim/nvim-lspconfig",
	event = "BufReadPre",
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		"folke/neodev.nvim",
		"simrat39/rust-tools.nvim",
	},
}

function M.config()
	require("neodev").setup({})

	local wk = require("which-key")

	-- Use an on_attach function to only map the following keys
	-- after the language server attaches to the current buffer
	local on_attach = function(client, bufnr)
		require("config.plugins.lsp.formatting").setup(client, bufnr)

		local keymaps = {
			buffer = bufnr,
			["<leader>"] = {
				c = {
					name = "+code",
					d = { vim.diagnostic.open_float, "Line diagnostics" },
					s = { require("telescope.builtin").lsp_document_symbols, "Document symbols" },
					l = {
						s = { require("telescope.builtin").lsp_dynamic_workspace_symbols, "Workspace symbols" },
						a = { vim.lsp.buf.add_workspace_folder, "Add workspace folder" },
						d = { vim.lsp.buf.remove_workspace_folder, "Remove workspace folder" },
						l = {
							function()
								print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
							end,
							"List workspace folders",
						},
					},
					r = { vim.lsp.buf.rename, "Rename symbol under cursor" },
					a = { vim.lsp.buf.code_action, "Code action" },
					f = { vim.lsp.buf.format, "Format" },
				},
			},
			g = {
				name = "+goto",
				d = { require("telescope.builtin").lsp_definitions, "Goto definition" },
				D = { require("telescope.builtin").lsp_declarations, "Goto declarations" },
				r = { require("telescope.builtin").lsp_references, "Show references" },
				t = { require("telescope.builtin").lsp_type_definitions, "Goto type definition" },
			},
			K = { vim.lsp.buf.hover, "Hover" },
			["<C-k>"] = { vim.lsp.buf.signature_help, "Signature help", mode = { "n", "i" } },
			["[d"] = { vim.diagnostic.goto_prev, "Goto previous diagnostic" },
			["]d"] = { vim.diagnostic.goto_next, "Goto next diagnostic" },
		}

		wk.register(keymaps)
	end

	-- Add additional capabilities supported by nvim-cmp
	local capabilities = vim.lsp.protocol.make_client_capabilities()
	capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

	local lspconfig = require("lspconfig")

	local servers = {
		clangd = {},
		tsserver = {},
		jedi_language_server = {},
		nil_ls = {},
		zls = {},
		sumneko_lua = {
			single_file_support = true,
			settings = {
				Lua = {
					workspace = {
						checkThirdParty = false,
					},
					completion = {
						workspaceWord = true,
						callSnippet = "Both",
					},
					format = {
						enable = false,
					},
					telemetry = {
						enable = false,
					},
				},
			},
		},
	}

	for server, settings in pairs(servers) do
		lspconfig[server].setup({
			on_attach = on_attach,
			capabilities = capabilities,
			settings = settings.settings,
		})
	end

	require("rust-tools").setup({
		server = {
			on_attach = on_attach,
			capabilities = capabilities,
		},
	})

	require("config.plugins.null-ls").setup({
		on_attach = on_attach,
	})
end

return M
