require("config.lazy")
checker = { enabled = true, notify = false }
news = {lazyvim = false}

vim.api.nvim_create_autocmd("FileType", {
  pattern = "verilog,systemverilog",
  callback = function()
    vim.cmd("TSDisable highlight")
  end,
})
