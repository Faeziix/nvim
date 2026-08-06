return {
  {
    "mrcjkb/rustaceanvim",
    version = "^6", -- Recommended
    ft = "rust",
  },
  {
    "saecki/crates.nvim",
    ft = "rust",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("crates").setup()
    end,
  },
}
