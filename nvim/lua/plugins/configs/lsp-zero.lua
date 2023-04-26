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
		"VonHeikemen/lsp-zero.nvim",
		branch = "v2.x",
		lazy = true,
		config = function()
			require("lsp-zero.settings").preset({})
		end,
	},
	{
		"jose-elias-alvarez/null-ls.nvim",
		event = "BufReadPre",
		dependencies = { "mason.nvim" },
	},
	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"saadparwaiz1/cmp_luasnip",
			"hrsh7th/cmp-nvim-lua",
			"L3MON4D3/LuaSnip",
		},
		config = function()
			require("lsp-zero.cmp").extend()

			-- And you can configure cmp even more, if you want to.
			local cmp = require("cmp")
			local luasnip = require("luasnip")
			local compare = require("cmp.config.compare")
			local lspkind = require("lspkind")
			local cmp_action = require("lsp-zero.cmp").action()

			cmp.setup({
				sources = {
					{ name = "luasnip" },
					{ name = "nvim_lsp" },
					{ name = "buffer" },
					{ name = "path" },
				},
				mapping = {
					["<C-b>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),
					["<C-e>"] = cmp.mapping.abort(),
					["<CR>"] = cmp.mapping.confirm({
						behavior = cmp.ConfirmBehavior.Replace,
						select = true,
					}),
					["<Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_next_item()
						elseif luasnip.expand_or_jumpable() then
							luasnip.expand_or_jump()
						else
							fallback()
						end
					end, { "i", "s" }),
					["<S-Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_prev_item()
						elseif luasnip.jumpable(-1) then
							luasnip.jump(-1)
						else
							fallback()
						end
					end, { "i", "s" }),
				},
				formatting = {
					fields = { "kind", "abbr", "menu" },
					format = function(entry, vim_item)
						local kind = lspkind.cmp_format({ mode = "symbol_text", maxwidth = 50 })(entry, vim_item)
						local strings = vim.split(kind.kind, "%s", { trimempty = true })
						kind.kind = " " .. (strings[1] or "") .. " "
						kind.menu = "    (" .. (strings[2] or "") .. ")"

						return kind
					end,
				},
				sorting = {
					priority_weight = 2,
					comparators = {
						compare.offset,
						compare.exact,
						compare.score,
						compare.kind,
						compare.sort_text,
						compare.length,
						compare.order,
					},
				},
				view = {
					entries = "custom", -- can be "custom", "wildmenu" or "native"
				},
				completion = {
					completeopt = "menu,menuone,noinsert",
				},
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		cmd = "LspInfo",
		event = { "BufReadPre", "BufNewFile" },
		opts = {
			diagnostics = {
				underline = true,
				update_in_insert = false,
				virtual_text = { spacing = 4, prefix = "●" },
				severity_sort = true,
			},
		},
		dependencies = {
			{ "hrsh7th/cmp-nvim-lsp" },
			{ "williamboman/mason-lspconfig.nvim" },
			{
				"williamboman/mason.nvim",
				build = function()
					pcall(vim.cmd, "MasonUpdate")
				end,
			},
		},
		config = function()
			-- This is where all the LSP shenanigans will live

			local lsp = require("lsp-zero")

			lsp.set_sign_icons({ error = " ", warn = " ", hint = " ", info = " " })

			lsp.on_attach(function(client, bufnr)
				cmd("command! LspDef lua vim.lsp.buf.definition()")
				cmd("command! LspFormatting lua vim.lsp.buf.format({async = true})")
				cmd("command! LspHover lua vim.lsp.buf.hover()")
				cmd("command! LspRename lua vim.lsp.buf.rename()")
				cmd("command! LspTypeDef lua vim.lsp.buf.type_definition()")
				cmd("command! LspImplementation lua vim.lsp.buf.implementation()")
				cmd("command! LspReferences lua vim.lsp.buf.references()")
				cmd("command! LspDiagPrev lua vim.diagnostic.goto_prev()")
				cmd("command! LspDiagNext lua vim.diagnostic.goto_next()")
				cmd("command! LspDiagLine lua vim.diagnostic.show_line_diagnostics()")
				cmd("command! LspSignatureHelp lua vim.lsp.buf.signature_help()")

				map("n", "lp", ":LspDiagPrev<CR>", opts)
				map("n", "ln", ":LspDiagNext<CR>", opts)

				map("n", "gh", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
				map("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
				map("n", "gf", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
				map("n", "gr", "<cmd>:LspReferences<CR>", opts)
				map("n", "gi", "<cmd>:LspImplementation<CR>", opts)
				map("n", "gs", "<cmd>LspSignatureHelp<CR>", opts)

				map("n", "<Leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
				map("v", "<Leader>ca", ":<C-U>lua vim.lsp.buf.range_code_action()<CR>", opts)
				map("n", "<Leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)

				vim.api.nvim_create_autocmd("CursorHold", {
					buffer = bufnr,
					callback = function()
						vim.diagnostic.open_float(nil, {
							focusable = false,
							close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
							border = "rounded",
							source = "always",
							prefix = " ",
							scope = "cursor",
						})
					end,
				})
			end)

			lsp.format_on_save({
				format_opts = {
					timeout_ms = 10000,
				},
				servers = {
					["null-ls"] = { "javascript", "typescript", "javascriptreact", "typescriptreact", "lua" },
				},
			})

			-- (Optional) Configure lua language server for neovim
			require("lspconfig").lua_ls.setup(lsp.nvim_lua_ls())

			lsp.ensure_installed({
				-- Replace these with whatever servers you want to install
				"tsserver",
				"eslint",
				"prismals",
			})

			lsp.configure("tsserver", {
				single_file_support = false,
				commands = {
					OrganizeImports = {
						organize_imports,
						description = "Organize Imports",
					},
				},
			})

			lsp.setup()

			local null_ls = require("null-ls")

			null_ls.setup({
				sources = {
					-- Replace these with the tools you have installed
					null_ls.builtins.formatting.prettierd,
					null_ls.builtins.formatting.yamlfmt,
					null_ls.builtins.formatting.prismaFmt,
					null_ls.builtins.formatting.stylua,
					null_ls.builtins.completion.spell.with({
						filetypes = { "markdown" },
					}),
				},
			})
		end,
	},
	{ "JoosepAlviste/nvim-ts-context-commentstring", lazy = true },
}
