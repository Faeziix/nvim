return {
  "tpope/vim-fugitive",
  lazy = false,
  init = function()
    local map = require "custom.mappings"

    map.fugitive = {
      n = {
        ["<leader>gs"] = { ":Git<CR>", "Open Git Fugitive" },
        ["<leader>gc"] = { ":Telescope git_branches<CR>", "Open git branch" },
        ["<leader>gj"] = { ":diffget //2<CR>", "accept HEAD" },
        ["<leader>gk"] = { ":diffget //3<CR>", "accept New Change" },
      },
    }
  end,
}
