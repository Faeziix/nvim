return {
  {
    'razak17/tailwind-fold.nvim',
    opts = {},
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    ft = { 'html', 'typescriptreact' },
    init = function()
      local map = require "custom.mappings"
      map.tailwind_fold = {
        n = {
          ["<leader>tf"] = { ":TailwindFoldToggle<cr>", "Toggle Tailwind Fold" },
        },
      }
    end
  },
  {
    "NvChad/nvim-colorizer.lua",
    opts = {
      user_default_options = {
        tailwind = true
      }
    },
  }
}
