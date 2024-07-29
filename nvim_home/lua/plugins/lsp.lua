return {
	{
		"williamboman/mason.nvim",
		cmd = "Mason",
		keys = { { "<leader>cm", "<cmd>Mason<cr>", desc = "Mason" } },
		build = ":MasonUpdate",
		opts = {
			ensure_installed = {
				"stylua",
				"prettierd",
				"solargraph",
				"vue-language-server",
			},
		},
		---@param opts MasonSettings | {ensure_installed: string[]}
		config = function(_, opts)
			require("mason").setup(opts)
			local mr = require("mason-registry")
			local function ensure_installed()
				for _, tool in ipairs(opts.ensure_installed) do
					local p = mr.get_package(tool)
					if not p:is_installed() then
						p:install()
					end
				end
			end
			if mr.refresh then
				mr.refresh(ensure_installed)
			else
				ensure_installed()
			end
		end,
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

			require("luasnip").filetype_extend("javascriptreact", { "html" })
			require("luasnip").filetype_extend("typescriptreact", { "html" })
			require("luasnip").filetype_extend("vue", { "html" })

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
	{
		"neovim/nvim-lspconfig",
		opts = {
			inlay_hints = {
				enabled = false,
				exclude = {}, -- filetypes for which you don't want to enable inlay hints
			}, -- Good for debugging
			format_notify = false,
			servers = {
				lua_ls = {},
				solargraph = {
					"ruby",
					"rakefile",
					settings = {
						solargraph = {
							autoformat = true,
							completion = true,
							diagnostic = true,
							folding = true,
							references = true,
							rename = true,
							symbols = true,
						},
					},
				},
				-- tsserver = {
				--   filetypes = { "javascriptreact", "typescriptreact", "json" },
				-- },
				volar = {
					tsdk = vim.fn.expand("$HOME/.config/yarn/global/node_modules/typescript"),
					filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue", "json" },
				},
				stylelint_lsp = {
					filetypes = { "css", "scss", "less", "vue", "html" },
				},
				eslint = {
					settings = {
						workingDirectory = { mode = "auto" },
					},
				},
			},
			setup = {
				volar = function()
					require("lazyvim.util").lsp.on_attach(function(client)
						if client.name == "volar" then
							client.server_capabilities.documentFormattingProvider = false
						elseif client.name == "tsserver" then
							client.server_capabilities.documentFormattingProvider = false
						elseif client.name == "eslint" then
							client.server_capabilities.documentFormattingProvider = true
						end
					end)
				end,
			},
		},
	},
}
