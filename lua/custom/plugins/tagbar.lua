return {
  "majutsushi/tagbar",
  cmd = "TagbarToggle",
  ft = {
    "c",
    "cpp",
    "go",
    "lua",
    "python",
    "rust",
    "sh",
    "typescript",
    "javascript",
    "html",
    "css",
    "vim",
    "typescriptreact",
  },
  init = function()
    local map = require "custom.mappings"

    map.tagbar = {
      n = {
        ["<leader>tb"] = { "<cmd>TagbarToggle<cr>", "Toggle Tagbar" },
      },
    }
  end,
}
