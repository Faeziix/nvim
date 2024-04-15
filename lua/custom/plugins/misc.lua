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
  { "wakatime/vim-wakatime", lazy = false },
  {
    "numToStr/Comment.nvim",
    dependencies = "JoosepAlviste/nvim-ts-context-commentstring",
    config = function()
      require("Comment").setup {
        pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
      }
    end,
  },
  {
    "vimwiki/vimwiki",
    lazy = false,
    init = function()
      vim.g.vimwiki_ext2syntax = {
        [".Rmd"] = "markdown",
        [".rmd"] = "markdown",
        [".md"] = "markdown",
        [".markdown"] = "markdown",
        [".mdown"] = "markdown",
      }
      vim.api.nvim_set_keymap("n", "<leader>v", ":VimwikiIndex", { noremap = true })
      vim.g.vimwiki_list = { { path = "~/vimwiki", syntax = "markdown", ext = ".md" } }
    end,
  },
  {
    "kevinhwang91/nvim-bqf",
    dependencies = "junegunn/fzf",
    event = "VeryLazy",
    keys = { "gr", "gd", "gD" },
  },
  {
    "junegunn/fzf",
    lazy = false,
  },
  -- {
  --   "echasnovski/mini.nvim",
  --   version = false,
  --   event = "VeryLazy",
  --   config = function()
  --     -- require("mini.ai").setup()
  --   end,
  -- },
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
    "mattn/emmet-vim",
    ft = { "html", "javascript", "javascriptreact", "typescript", "typescriptreact", "xml" },
    init = function()
      vim.g.user_emmet_leader_key = "<C-Z>"
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
    "vigoux/notifier.nvim",
    event = "VeryLazy",
    config = function()
      require("notifier").setup {
        -- You configuration here
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
}

return plugins
