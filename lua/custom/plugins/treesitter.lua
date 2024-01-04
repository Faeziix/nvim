return {
  {
    "nvim-treesitter/nvim-treesitter-context",
    after = "nvim-treesitter",
    event = "BufRead",
  },
  {
    "nvim-treesitter/nvim-treesitter",
    init = function()
      require("core.utils").lazy_load "nvim-treesitter"
    end,
    cmd = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSModuleInfo" },
    build = ":TSUpdate",
    opts = {
      ensure_installed = { "lua" },

      highlight = {
        enable = true,
        use_languagetree = true,
      },

      auto_install = true,

      indent = { enable = true },
    },
    config = function(_, opts)
      dofile(vim.g.base46_cache .. "syntax")
      require("nvim-treesitter.configs").setup(opts)

      vim.filetype.add {
        extension = {
          mdx = "mdx",
        },
      }

      vim.treesitter.language.register("markdown", "mdx")
    end,
  },
}
