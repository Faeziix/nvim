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
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
    },
    opts = {
      ensure_installed = { "lua" },
      ignore_install = { "org" },
      highlight = {
        enable = true,
        use_languagetree = true,
      },
      indent = { enable = true },
      textobjects = {
        select = {
          enable = true,
          lookahead = true,
          keymaps = {
            -- You can use the capture groups defined in textobjects.scm
            ['af'] = '@function.outer',
            ['if'] = '@function.inner',
            ['ac'] = '@class.outer',
            ['ic'] = '@class.inner',
          },
        },
      },
      rainbow = { enable = true, extended_mode = true, max_file_lines = 1000 },
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
