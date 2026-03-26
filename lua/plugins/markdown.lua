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
    "MeanderingProgrammer/render-markdown.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-mini/mini.nvim" }, -- if you use the mini.nvim suite
    ft = { "markdown", "mdx", "vimwiki" },
    -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-mini/mini.icons' },        -- if you use standalone mini plugins
    -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
    ---@module 'render-markdown'
    ---@type render.md.UserConfig
    opts = {
      checkbox = { checked = { scope_highlight = "@markup.strikethrough" } },
    },
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
