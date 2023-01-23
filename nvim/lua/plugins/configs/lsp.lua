local cmd = vim.cmd
local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

local function organize_imports()
	local params = {
		command = "_typescript.organizeImports",
		arguments = { vim.api.nvim_buf_get_name(0) },
		title = "",
	}
	vim.lsp.buf.execute_command(params)
end

return {
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup()
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = {
					-- Replace these with whatever servers you want to install
					"rust_analyzer",
					"tsserver",
				},
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		opts = {
			diagnostics = {
				underline = true,
				update_in_insert = false,
				virtual_text = { spacing = 4, prefix = "●" },
				severity_sort = true,
			},
		},
		config = function()
			local lsp_capabilities = require("cmp_nvim_lsp").default_capabilities()
			local lsp_attach = function(client, bufnr)
				client.server_capabilities.documentFormattingProvider = false
				client.server_capabilities.documentRangeFormattingProvider = false

				-- Map to easier commands
				cmd("command! LspDef lua vim.lsp.buf.definition()")
				cmd("command! LspFormatting lua vim.lsp.buf.formatting()")
				cmd("command! LspHover lua vim.lsp.buf.hover()")
				cmd("command! LspRename lua vim.lsp.buf.rename()")
				cmd("command! LspTypeDef lua vim.lsp.buf.type_definition()")
				cmd("command! LspImplementation lua vim.lsp.buf.implementation()")
				cmd("command! LspDiagPrev lua vim.diagnostic.goto_prev()")
				cmd("command! LspDiagNext lua vim.diagnostic.goto_next()")
				cmd("command! LspDiagLine lua vim.diagnostic.show_line_diagnostics()")
				cmd("command! LspSignatureHelp lua vim.lsp.buf.signature_help()")

				cmd([[autocmd BufWritePre * lua vim.lsp.buf.format()]])

				map("n", "lp", ":LspDiagPrev<CR>", opts)
				map("n", "ln", ":LspDiagNext<CR>", opts)

				map("n", "gh", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
				map("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
				map("n", "gf", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
				map("n", "gs", "<cmd>LspSignatureHelp<CR>", opts)

				map("n", "<Leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
				map("v", "<Leader>ca", ":<C-U>lua vim.lsp.buf.range_code_action()<CR>", opts)
				map("n", "<Leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
			end

			local lspconfig = require("lspconfig")
			require("mason-lspconfig").setup_handlers({
				function(server_name)
					lspconfig[server_name].setup({
						on_attach = lsp_attach,
						capabilities = lsp_capabilities,
						commands = {
							OrganizeImports = {
								organize_imports,
								description = "Organize Imports",
							},
						},
					})
				end,
			})
		end,
	},
	{
		"jose-elias-alvarez/null-ls.nvim",
		event = "BufReadPre",
		dependencies = { "mason.nvim" },
		opts = function()
			local nls = require("null-ls")
			return {
				sources = {
					nls.builtins.formatting.prettierd,
					nls.builtins.formatting.stylua,
				},
			}
		end,
	},
	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"saadparwaiz1/cmp_luasnip",
		},
		opts = function()
			local cmp = require("cmp")
			return {
				completion = {
					completeopt = "menu,menuone,noinsert",
				},
				snippet = {
					expand = function(args)
						require("luasnip").lsp_expand(args.body)
					end,
				},
				mapping = cmp.mapping.preset.insert({
					["<C-b>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),
					["<C-Space>"] = cmp.mapping.complete(),
					["<C-e>"] = cmp.mapping.abort(),
					["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
				}),
				sources = cmp.config.sources({
					{ name = "nvim_lsp" },
					{ name = "luasnip" },
					{ name = "buffer" },
					{ name = "path" },
				}),
				experimental = {
					ghost_text = {
						hl_group = "LspCodeLens",
					},
				},
			}
		end,
	},
	{ "JoosepAlviste/nvim-ts-context-commentstring", lazy = true },
}
