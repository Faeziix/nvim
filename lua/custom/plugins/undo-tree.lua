return {
  {
    "mbbill/undotree",
    keys = {
      "<leader>fu",
    },
    cmd = {
      "UndotreeToggle",
    },
    init = function()
      local map = require "custom.mappings"

      map.undotree = {
        n = {
          ["<leader>fu"] = { ":UndotreeToggle<cr>", "Toggle UndoTree" },
        },
      }
    end,
  },
}
