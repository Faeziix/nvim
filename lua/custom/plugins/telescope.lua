return {
  "nvim-telescope/telescope.nvim",
  dependencies = { "nvim-treesitter/nvim-treesitter", { "nvim-telescope/telescope-fzf-native.nvim", build = "make" } },
  cmd = "Telescope",
  init = function()
    require("core.utils").load_mappings "telescope"
    local map = require "custom.mappings"
    map.telescope = {
      n = {
        ["<leader>F"] = { ":Telescope recents <CR>", "Find files" },
        ["<leader>fp"] = { ":Telescope projects<CR>", "Search Projects" },
        ["<leader>fq"] = { ":Telescope quickfix<CR>", "Search Quickfix" },
        ["<leader>fl"] = { ":Telescope loclist<CR>", "Search Location List" },
        ["<leader>fs"] = { ":Telescope spell_suggest<CR>", "Search Spelling Suggestions" },
        ["<leader>fo"] = { ":Telescope oldfiles<CR>", "Search Oldfiles" },
      },
    }
  end,
  config = function(_, opts)
    dofile(vim.g.base46_cache .. "telescope")
    local telescope = require "telescope"
    telescope.setup(opts)
    -- load extensions
    telescope.load_extension "projects"
    for _, ext in ipairs(opts.extensions_list) do
      telescope.load_extension(ext)
    end
  end,
}
