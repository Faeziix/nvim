local leet_arg = "leetcode.nvim"
return {
  "kawre/leetcode.nvim",
  lazy = leet_arg ~= vim.fn.argv()[1],
  opts = {
    arg = leet_arg,
    lang = "javascript",
  },
  build = ":TSUpdate html",
  dependencies = {
    "nvim-telescope/telescope.nvim",
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    "nvim-treesitter/nvim-treesitter",
    -- "rcarriga/nvim-notify",
    "nvim-tree/nvim-web-devicons",
  },
  init = function()
    if leet_arg ~= vim.fn.argv()[1] then
      return
    end
    local map = require "custom.mappings"
    map.leetcode = {
      n = {
        ["<leader>lr"] = {
          "<cmd> Leet run <CR>",
          ":Leet run",
        },
        ["<leader>ls"] = {
          "<cmd> Leet submit <CR>",
          ":Leet submit",
        },
        ["<leader>lc"] = {
          "<cmd> Leet close <CR>",
          ":Leet close",
        },
        ["<leader>lm"] = {
          "<cmd> Leet menu <CR>",
          ":Leet menu",
        },
        ["<leader>ld"] = {
          "<cmd> Leet desc <CR>",
          ":Leet desc",
        },
      },
    }
  end,
}
