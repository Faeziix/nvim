return {
  {
    {
      "iamcco/markdown-preview.nvim",
      ft = "markdown",
      cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
      build = function()
        vim.fn["mkdp#util#install"]()
      end,
    },
  },
  {
    "MeanderingProgrammer/markdown.nvim",
    name = "render-markdown", -- Only needed if you have another plugin named markdown.nvim
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    event = "VeryLazy",
    -- config = function(opts)
    --   vim.api.nvim_set_hl(0, "h1", { fg = "#7dcfff", bg = "#2e2e2f", bold = true })
    --   vim.api.nvim_set_hl(0, "h2", { fg = "#faaaaf", bg = "#2e2e3e", bold = true })
    --   vim.api.nvim_set_hl(0, "h3", { fg = "#bb9af7", bg = "#2e3e4e", bold = true })
    --   vim.api.nvim_set_hl(0, "h4", { fg = "#e0af68", bg = "#3e3e2e", bold = true })
    --   vim.api.nvim_set_hl(0, "h5", { fg = "#9ece6a", bg = "#2e3e2e", bold = true })
    --
    --   require("render-markdown").setup {
    --     file_types = { "markdown", "vimwiki", "md", "Avante" },
    --     bullets = { "◉", "○", "✸", "✿" },
    --     highlights = {
    --       heading = {
    --         backgrounds = { "h1", "h2", "h3", "h4", "h5", "h6" },
    --       },
    --     },
    --     treesitter = {
    --       override_highlight = true,
    --     },
    --     win_options = {
    --       concealcursor = {
    --         rendered = "",
    --       },
    --     },
    --   }
    -- end,
  },
  {
    "vimwiki/vimwiki",
    lazy = false,
    init = function()
      vim.g.vimwiki_ext2syntax = {
        [".md"] = "markdown",
      }
      vim.g.vimwiki_list = { { path = "~/vimwiki", syntax = "markdown", ext = ".md" } }
      vim.g.vimwiki_global_ext = 0
      vim.treesitter.language.register("markdown", "vimwiki")
    end,
  },
  {
    "nvim-treesitter/playground",
    lazy = false,
  },
}
