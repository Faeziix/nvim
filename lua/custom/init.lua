-------------------------------------- options ------------------------------------------
vim.opt.cursorline = true
vim.opt.so = 10
vim.opt.siso = 10
vim.opt.hlsearch = true
vim.opt.relativenumber = true
vim.opt.swapfile = false
vim.opt.conceallevel = 2
vim.opt.concealcursor = ''

vim.filetype.add {
  extension = { mdx = "mdx" },
}

-- vim.treesitter.language.register("mdx", "markdown")

local autocmd = vim.api.nvim_create_autocmd

autocmd("FileType", {
  pattern = { "rust" },
  callback = function(ev)
    local utils = require "core.utils"
    utils.load_mappings("lspconfig", { buffer = ev.buf })
  end,
})

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

vim.api.nvim_command('au BufNewFile,BufRead *.log set filetype=log')

-- vim.api.nvim_create_autocmd({"BufRead", "BufNewFile"}, {
--   pattern = {"*.md", "*.markdown"},
--   callback = function()
--     vim.bo.filetype = "lsp_markdown"
--   end
-- })
