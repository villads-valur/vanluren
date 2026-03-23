local opt = vim.opt

opt.conceallevel = 0 -- dont' conceal "" and ''
opt.swapfile = false -- don't use swapfile
vim.g.lazyvim_eslint_auto_format = false
vim.g.lazyvim_prettier_needs_config = true

local npmCacheDir = vim.fn.stdpath("data") .. "/npm-cache"
vim.fn.mkdir(npmCacheDir, "p")
vim.env.NPM_CONFIG_CACHE = npmCacheDir

vim.api.nvim_create_user_command("SortJsonKeys", function()
  if vim.bo.filetype ~= "json" then
    print("Not a json file")
    return
  end

  return vim.cmd("%!jq . -S")
end, { desc = "Sort json keys" })
