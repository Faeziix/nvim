return {
  "nvim-telescope/telescope.nvim",
  dependencies = { "nvim-treesitter/nvim-treesitter", { "nvim-telescope/telescope-fzf-native.nvim", build = "make" } },
  cmd = "Telescope",
  init = function()
    require("core.utils").load_mappings "telescope"
    local map = require "custom.mappings"
    map.telescope = {
      n = {
        ["<leader>F"] = { "<cmd> Telescope recents <CR>", "Find files" },
      },
    }
  end,
  config = function(_, opts)
    dofile(vim.g.base46_cache .. "telescope")
    local telescope = require "telescope"
    telescope.setup(opts)
    -- load extensions
    for _, ext in ipairs(opts.extensions_list) do
      telescope.load_extension(ext)
    end
  end,
}
