return {
  "laytan/cloak.nvim",
  ft = { "sh" },
  lazy= false,
  opts = {
    enabled = true,
    cloak_character = "*",
    highlight_group = "Comment",
    cloak_length = nil,
    try_all_patterns = true,
    patterns = {
      {
        file_pattern = ".env*",
        cloak_pattern = "=.+",
        replace = nil,
      },
    },
  },
  init = function()
    local map = require "custom.mappings"
    map.cloak = {
      n = {
        ["<leader>ct"] = { "<cmd> CloakToggle <CR>", "Cloak Toggle" },
      },
    }
  end,
}
