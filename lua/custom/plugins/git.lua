return {
  {
    "tpope/vim-fugitive",
    lazy = false,
    init = function()
      local map = require "custom.mappings"

      map.fugitive = {
        n = {
          ["<leader>gs"] = { ":Git<CR>", "Open Git Fugitive" },
          ["<leader>gps"] = { ":Git push<CR>", "Open Git Fugitive" },
          ["<leader>gpl"] = { ":Git pull<CR>", "Open Git Fugitive" },
          ["<leader>gc"] = { ":Telescope git_branches<CR>", "Open git branch" },
          ["<leader>gj"] = { ":diffget //2<CR>", "accept HEAD" },
          ["<leader>gk"] = { ":diffget //3<CR>", "accept New Change" },
          ["<leader>grh"] = { ":Git reset --hard<CR>", "Reset (Hard)" },
        },
      }
    end,
  },
  {
    "sindrets/diffview.nvim",
    dependencies = {
      { "nvim-lua/plenary.nvim" },
      { "nvim-tree/nvim-web-devicons" },
    },
    lazy = false,
    config = function()
      vim.opt.fillchars = "diff:╱"
      -- vim.opt.fillchars = "diff:░"

      require("diffview").setup {
        file_panel = {
          win_config = {
            position = "bottom",
          },
        },
        enhanced_diff_hl = true, -- See ':h diffview-config-enhanced_diff_hl'
      }
    end,
    keys = {
      -- use [c and [c to navigate diffs (vim built in), see :h jumpto-diffs
      -- use ]x and [x to navigate conflicts
      { "<leader>gdc", ":DiffviewOpen origin/main...HEAD", desc = "Compare commits" },
      { "<leader>gdd", ":DiffviewClose<CR>", desc = "Close Diffview tab" },
      { "<leader>gdh", ":DiffviewFileHistory %<CR>", desc = "File history" },
      { "<leader>gdH", ":DiffviewFileHistory<CR>", desc = "Repo history" },
      { "<leader>gdm", ":DiffviewOpen<CR>", desc = "Solve merge conflicts" },
      { "<leader>gdo", ":DiffviewOpen main", desc = "DiffviewOpen" },
      { "<leader>gdp", ":DiffviewOpen origin/main...HEAD --imply-local", desc = "Review current PR" },
      {
        "<leader>gdP",
        ":DiffviewFileHistory --range=origin/main...HEAD --right-only --no-merges",
        desc = "Review current PR (per commit)",
      },
    },
    init = function()
      local map = require "custom.mappings"

      map.git = {
        n = {
          ["<leader>gdc"] = { ":DiffviewOpen origin/main...HEAD<CR>", "Compare commits" },
          ["<leader>gdd"] = { ":DiffviewClose<CR>", "Close Diffview tab" },
          ["<leader>gdh"] = { ":DiffviewFileHistory %<CR>", "File history" },
          ["<leader>gdH"] = { ":DiffviewFileHistory<CR>", "Repo history" },
          ["<leader>gdm"] = { ":DiffviewOpen<CR>", "Solve merge conflicts" },
          ["<leader>gdo"] = { ":DiffviewOpen main<CR>", "DiffviewOpen" },
          ["<leader>gdp"] = { ":DiffviewOpen origin/main...HEAD --imply-local<CR>", "Review current PR" },
          ["<leader>gdP"] = {
            ":DiffviewFileHistory --range=origin/main...HEAD --right-only --no-merges<CR>",
            "Review current PR (per commit)",
          },
        },
      }
    end,
  },
}
