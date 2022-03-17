local present, impatient = pcall(require, "impatient")

if present then
	impatient.enable_profile()
end

-- Settings
require("settings")
require("mappings")
require("colorschemes")

require("plugins")
