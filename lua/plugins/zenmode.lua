return {
  "folke/zen-mode.nvim",
  event = "BufRead",
  opts = {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
  },
  init = function()
    local map = require("custom.mappings")
    map.zenmode = {
      n = {
        ["<leader>z"] = { ":ZenMode<CR>", "Zen Mode" },
      },
    }
  end
}
