local opt = vim.opt

opt.conceallevel = 0 -- dont' conceal "" and ''
opt.swapfile = false -- don't use swapfile

vim.api.nvim_create_user_command("SortJsonKeys", function()
  if vim.bo.filetype ~= "json" then
    print("Not a json file")
    return
  end

  return vim.cmd("%!jq . -S")
end, { desc = "Sort json keys" })
