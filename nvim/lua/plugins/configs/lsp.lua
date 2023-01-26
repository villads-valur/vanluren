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
			local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
			for type, icon in pairs(signs) do
				local hl = "DiagnosticSign" .. type
				vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
			end
			local lsp_capabilities = require("cmp_nvim_lsp").default_capabilities()
			local lsp_attach = function(client, bufnr)
				client.server_capabilities.documentFormattingProvider = false
				client.server_capabilities.documentRangeFormattingProvider = false

				-- Map to easier commands
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

				cmd([[autocmd BufWritePre * lua vim.lsp.buf.format()]])

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
	{ "JoosepAlviste/nvim-ts-context-commentstring", lazy = true },
}
