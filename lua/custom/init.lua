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

vim.treesitter.language.register("mdx", "markdown")

local autocmd = vim.api.nvim_create_autocmd

autocmd("FileType", {
  pattern = { "rust" },
  callback = function(ev)
    local utils = require "core.utils"
    utils.load_mappings("lspconfig", { buffer = ev.buf })
  end,
})

-- Styled and colored underline support
-- vim.api.nvim_set_option('t_AU', '\27[58:5:%dm')
-- vim.api.nvim_set_option('t_8u', '\27[58:2:%lu:%lu:%lum')
-- vim.api.nvim_set_option('t_Us', '\27[4:2m')
-- vim.api.nvim_set_option('t_Cs', '\27[4:3m')
-- vim.api.nvim_set_option('t_ds', '\27[4:4m')
-- vim.api.nvim_set_option('t_Ds', '\27[4:5m')
-- vim.api.nvim_set_option('t_Ce', '\27[4:0m')

-- Strikethrough
-- vim.api.nvim_set_option('t_Ts', '\27[9m')
-- vim.api.nvim_set_option('t_Te', '\27[29m')

-- Truecolor support
-- vim.api.nvim_set_option('t_8f', '\27[38:2:%lu:%lu:%lum')
-- vim.api.nvim_set_option('t_8b', '\27[48:2:%lu:%lu:%lum')
-- vim.api.nvim_set_option('t_RF', '\27]10;?\27\\')
-- vim.api.nvim_set_option('t_RB', '\27]11;?\27\\')

-- Bracketed paste
-- vim.api.nvim_set_option('t_BE', '\27[?2004h')
-- vim.api.nvim_set_option('t_BD', '\27[?2004l')
-- vim.api.nvim_set_option('t_PS', '\27[200~')
-- vim.api.nvim_set_option('t_PE', '\27[201~')

-- Cursor control
-- vim.api.nvim_set_option('t_RC', '\27[?12$p')
-- vim.api.nvim_set_option('t_SH', '\27[%d q')
-- vim.api.nvim_set_option('t_RS', '\27P$q q\27\\')
-- vim.api.nvim_set_option('t_SI', '\27[5 q')
-- vim.api.nvim_set_option('t_SR', '\27[3 q')
-- vim.api.nvim_set_option('t_EI', '\27[1 q')
-- vim.api.nvim_set_option('t_VS', '\27[?12l')

-- Focus tracking
-- vim.api.nvim_set_option('t_fe', '\27[?1004h')
-- vim.api.nvim_set_option('t_fd', '\27[?1004l')

-- Window title
-- vim.api.nvim_set_option('t_ST', '\27[22;2t')
-- vim.api.nvim_set_option('t_RT', '\27[23;2t')

-- Vim hardcodes background color erase even if the terminfo file does
-- not contain bce. This causes incorrect background rendering when
-- using a color theme with a background color in terminals such as
-- kitty that do not support background color erase.
-- vim.api.nvim_set_option('t_ut', '')

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
