return {
  "folke/todo-comments.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  event = "BufRead",
  config = function()
    require("todo-comments").setup {}
  end,
  init = function()
    local map = require("custom.mappings")

    map.todo_comments = {
      n = {
        ["<leader>tqf"] = { "<cmd>TodoQuickFix<cr>", "TodoQuickFix" },
        ["<leader>tqt"] = { "<cmd>TodoTelescope<cr>", "TodoTelescope" },
        ["<leader>tqo"] = { "<cmd>TodoTrouble<cr>", "TodoTrouble" },
      }
    }
  end
}
