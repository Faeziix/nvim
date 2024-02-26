return {
  "epwalsh/obsidian.nvim",
  version = "*", -- recommended, use latest release instead of latest commit
  lazy = true,
  event = "VeryLazy",
  dependencies = {
    -- Required.
    "nvim-lua/plenary.nvim",
  },
  opts = {
    workspaces = {
      {
        name = "Business",
        path = "~/Work/Obsidian/Business/",
        overrides = {
          notes_subdir = "Notes",
        },
      },
      {
        name = "German",
        path = "~/Work/Obsidian/German/",
      },
    },
  },
}
