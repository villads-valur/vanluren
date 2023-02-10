-- Description: Copilot configuration file
return {
	"zbirenbaum/copilot.lua",
	cmd = "Copilot",
	event = "InsertEnter",
	config = function()
		require("copilot").setup({
			enabled = true,
			auto_refresh = true,
			suggestion = {
				enabled = true,
				auto_trigger = true,
				debounce = 75,
				keymap = {
					accept = "<C-j>",
				},
			},
		})
	end,
}
