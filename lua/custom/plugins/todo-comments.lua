return {
  "folke/todo-comments.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  event = "BufRead",
  opts = {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
  },
  init = function ()
    local map = require("custom.mappings")

    map.todo_comments = {
      n = {
        ["<leader>tqf"] = {"<cmd>TodoQuickFix<cr>", "TodoQuickFix"},
        ["<leader>Tqt"] = {"<cmd>TodoTelescope<cr>", "TodoTelescope"},
        ["<leader>Tqo"] = {"<cmd>TodoTrouble<cr>", "TodoTrouble"},
      }
    }
  end
}
