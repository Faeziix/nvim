-------------------------------------- options ------------------------------------------
vim.opt.cursorline = true
vim.opt.so = 10
vim.opt.hlsearch = false
vim.opt.showmatch = true
vim.opt.relativenumber = true
vim.opt.swapfile = false

vim.filetype.add {
  extension = { mdx = "mdx" },
}

vim.treesitter.language.register("mdx", "markdown")

local autocmd = vim.api.nvim_create_autocmd

autocmd("FileType", {
  pattern = { "rust" },
  callback = function(ev)
    local utils = require "core.utils"
    utils.load_mappings("lspconfig", { buffer = ev.buf })
  end,
})
