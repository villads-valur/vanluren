return {
	{
		"VonHeikemen/lsp-zero.nvim",
		branch = "v3.x",
		lazy = true,
		config = false,
		init = function()
			-- Disable automatic setup, we are doing it manually
			vim.g.lsp_zero_extend_cmp = 0
			vim.g.lsp_zero_extend_lspconfig = 0
		end,
	},
	{
		"williamboman/mason.nvim",
		lazy = false,
		config = true,
	},

	-- Autocompletion
	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		dependencies = {
			{ "L3MON4D3/LuaSnip" },
		},
		config = function()
			-- Here is where you configure the autocompletion settings.
			local lsp_zero = require("lsp-zero")
			lsp_zero.extend_cmp()

			-- And you can configure cmp even more, if you want to.
			local cmp = require("cmp")
			local cmp_action = lsp_zero.cmp_action()

			cmp.setup({
				formatting = lsp_zero.cmp_format({ details = true }),
				preselect = "item",
				completion = {
					completeopt = "menu,menuone,noinsert",
				},
				window = {
					completion = cmp.config.window.bordered(),
					documentation = cmp.config.window.bordered(),
				},
				mapping = cmp.mapping.preset.insert({

					["<CR>"] = cmp.mapping.confirm({ select = false }),
					["<C-u>"] = cmp.mapping.scroll_docs(-4),
					["<C-d>"] = cmp.mapping.scroll_docs(4),

					["<C-f>"] = cmp_action.luasnip_jump_forward(),
					["<C-b>"] = cmp_action.luasnip_jump_backward(),
					["<Tab>"] = cmp_action.luasnip_supertab(),
					["<S-Tab>"] = cmp_action.luasnip_shift_supertab(),
				}),
				snippet = {
					expand = function(args)
						require("luasnip").lsp_expand(args.body)
					end,
				},
			})
		end,
	},

	-- LSP
	{
		"neovim/nvim-lspconfig",
		cmd = { "LspInfo", "LspInstall", "LspStart" },
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			{ "hrsh7th/cmp-nvim-lsp" },
			{ "williamboman/mason-lspconfig.nvim" },
		},
		config = function()
			-- This is where all the LSP shenanigans will live
			local lsp_zero = require("lsp-zero")
			lsp_zero.extend_lspconfig()

			local vue_typescript_plugin = "/home/dev/.local/share/npm"
				.. "/lib/node_modules"
				.. "/@vue/language-server/node_modules"
				.. "@vue/typescript-plugin"

			lsp_zero.on_attach(function(client, bufnr)
				local opts = { buffer = bufnr }
				lsp_zero.default_keymaps({ buffer = bufnr, exclude = { "K" } })
				vim.keymap.set("n", "gr", "<cmd>Telescope lsp_references<cr>", opts)
				vim.keymap.set("n", "gh", "<cmd>lua vim.lsp.buf.hover()<cr>", opts)
				vim.keymap.set("n", "gd", "<cmd>lua vim.lsp.buf.declaration()<cr>", opts)
				vim.keymap.set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<cr>", opts)
				vim.keymap.set("n", "lp", "<cmd>lua vim.diagnostic.goto_prev()<cr>")
				vim.keymap.set("n", "ln", "<cmd>lua vim.diagnostic.goto_next()<cr>")
				vim.keymap.set("n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<cr>", opts)
			end)

			require("mason-lspconfig").setup({
				ensure_installed = { "volar", "tsserver", "jsonls" },
				handlers = {
					function(server_name)
						require("lspconfig")[server_name].setup({})
					end,
					tsserver = function()
						local vue_typescript_plugin = require("mason-registry")
							.get_package("vue-language-server")
							:get_install_path() .. "/node_modules/@vue/language-server" .. "/node_modules/@vue/typescript-plugin"

						require("lspconfig").tsserver.setup({
							init_options = {
								plugins = {
									{
										name = "@vue/typescript-plugin",
										location = vue_typescript_plugin,
										languages = { "javascript", "typescript", "vue" },
									},
								},
							},
							filetypes = {
								"javascript",
								"javascriptreact",
								"javascript.jsx",
								"typescript",
								"typescriptreact",
								"typescript.tsx",
								"vue",
							},
						})
					end,
					volar = function()
						require("lspconfig").volar.setup({})
					end,
				},
			})
		end,
	},
	{
		"onsails/lspkind.nvim",
		enabled = vim.g.icons_enabled,
		config = function(_, opts)
			require("lspkind").init(opts)
		end,
	},
}
