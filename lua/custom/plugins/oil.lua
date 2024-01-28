return {
  "stevearc/oil.nvim",
  cmd = { "Oil", "OilStart", "OilStop" },
  opts = {
    keymaps = {
      ["<BS>"] = "actions.parent",
    },
  },
  init = function()
    local map = require "custom.mappings"

    map.oil = {
      n = {
        ["<leader>o"] = { "<cmd>Oil<CR>", "Open Oil" },
      },
    }
  end,
}
