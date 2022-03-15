local present, impatient = pcall(require, "impatient")

if present then
	impatient.enable_profile()
end

if not vim.g.vscode then
	-- Settings
	require("settings")
	require("mappings")
	require("colorschemes")

	-- Plugins
	require("plugins/packer")

	-- LSP
	require("lsp")
end
