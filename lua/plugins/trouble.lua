return {
  "folke/trouble.nvim",
  event = "LspAttach",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  opts = {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
  },
  init = function()
    local map = require "custom.mappings"

    map.trouble = {
      n = {
        ["<leader>tt"] = { "<cmd>TroubleToggle<cr>" },
        ["<leader>tw"] = { "<cmd>TroubleToggle workspace_diagnostics<cr>" },
        ["<leader>td"] = { "<cmd>TroubleToggle document_diagnostics<cr>" },
      },
    }
  end,
}
