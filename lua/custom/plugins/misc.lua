local plugins = {
  {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup {
        -- Configuration here, or leave empty to use defaults
      }
    end,
  },
  {
    "numToStr/Comment.nvim",
    dependencies = "JoosepAlviste/nvim-ts-context-commentstring",
    keys = {
      { "gcc", mode = "n", desc = "Comment toggle current line" },
      { "gc", mode = { "n", "o" }, desc = "Comment toggle linewise" },
      { "gc", mode = "x", desc = "Comment toggle linewise (visual)" },
      { "gbc", mode = "n", desc = "Comment toggle current block" },
      { "gb", mode = { "n", "o" }, desc = "Comment toggle blockwise" },
      { "gb", mode = "x", desc = "Comment toggle blockwise (visual)" },
    },
    init = function()
      require("core.utils").load_mappings "comment"
    end,
    config = function()
      require("Comment").setup {
        pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
      }
    end,
  },
  {
    "junegunn/fzf",
    lazy = false,
  },
  {
    "nvim-mini/mini.nvim",
    version = false,
    event = "VeryLazy",
    config = function()
      -- require("mini.ai").setup()
      require("mini.cursorword").setup()
    end,
  },
  {
    "alvan/vim-closetag",
    event = "VeryLazy",
    init = function()
      vim.cmd [[
        let g:closetag_filenames = '*.html,*.xhtml,*.jsx,*.tsx'
        let g:closetag_xhtml_filenames = '*.xhtml,*.jsx,*.tsx'
        let g:closetag_filetypes = 'html,js'
        let g:closetag_xhtml_filetype = 'xhtml,jsx,tsx'
        let g:closetag_emptyTags_caseSensitive = 1
        let g:closetag_regions = {
        \ 'typescript.tsx': 'jsxRegion,tsxRegion',
        \ 'javascript.jsx': 'jsxRegion',
        \ }
        let g:closetag_shortcut = '>'
        ]]
    end,
  },
  {
    "ahmedkhalf/project.nvim",
    config = function()
      require("project_nvim").setup {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
      }
    end,
  },
  {
    "tpope/vim-unimpaired",
    event = "VeryLazy",
  },
  {
    "tpope/vim-speeddating",
    event = "VeryLazy",
  },
  {
    "djoshea/vim-autoread",
    event = "BufRead",
  },
}

return plugins
