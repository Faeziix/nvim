local plugins = {
  {
    "github/copilot.vim",
    lazy = false,
    config = function()
      vim.g.copilot_no_tab_map = true
      vim.g.copilot_assume_mapped = true
      vim.g.copilot_tab_fallback = ""
    end,
  },
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
    "tpope/vim-fugitive",
    lazy = false,
  },
  {
    "williamboman/mason.nvim",
    rm_default_opts = true,
  },
  -- Override plugin definition options
  {
    "neovim/nvim-lspconfig",
    rm_default_opts = true,
  },
  {
    "williamboman/mason-lspconfig.nvim",
  },
  {
    "VonHeikemen/lsp-zero.nvim",
    lazy = false,
    branch = "v2.x",
    config = function()
      require "custom.configs.lspconfig"
    end,
  },
  {
    "jose-elias-alvarez/null-ls.nvim",
    lazy = false,
    config = function()
      require "custom.configs.null-ls"
    end,
  },
  { "wakatime/vim-wakatime", lazy = false },
  { "pangloss/vim-javascript", lazy = false },
  {
    "nvim-treesitter/nvim-treesitter",
    init = function()
      require("core.utils").lazy_load "nvim-treesitter"
    end,
    cmd = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSModuleInfo" },
    build = ":TSUpdate",
    opts = function()
      return require "custom.configs.treesitter"
    end,
    config = function(_, opts)
      dofile(vim.g.base46_cache .. "syntax")
      require("nvim-treesitter.configs").setup(opts)
    end,
  },
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
  {
    "ThePrimeagen/harpoon",
    keys = { "<A-1>", "<A-2>", "<A-3>", "<A-4>", "<A-a>", "<A-S-h>" },
    event = "VeryLazy",
    init = function()
      require("harpoon").setup {}
    end,
  },
  {
    {
      "stevearc/conform.nvim",
      event = { "BufWritePre" },
      cmd = { "ConformInfo" },
      keys = {
        {
          -- Customize or remove this keymap to your liking
          "<leader>f",
          function()
            require("conform").format { async = true, lsp_fallback = true }
          end,
          mode = "",
          desc = "Format buffer",
        },
      },
      -- Everything in opts will be passed to setup()
      opts = {
        -- Define your formatters
        formatters_by_ft = {
          lua = { "stylua" },
          python = { "isort", "black" },
          javascript = { { "prettierd", "prettier" } },
        },
        -- Set up format-on-save
        format_on_save = { timeout_ms = 500, lsp_fallback = true },
        -- Customize formatters
        formatters = {
          shfmt = {
            prepend_args = { "-i", "2" },
          },
        },
      },
      init = function()
        -- If you want the formatexpr, here is the place to set it
        vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
      end,
    },
  },
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter", { "nvim-telescope/telescope-fzf-native.nvim", build = "make" } },
    cmd = "Telescope",
    init = function()
      require("core.utils").load_mappings "telescope"
    end,
    config = function(_, opts)
      dofile(vim.g.base46_cache .. "telescope")
      local telescope = require "telescope"
      telescope.setup(opts)
      -- load extensions
      for _, ext in ipairs(opts.extensions_list) do
        telescope.load_extension(ext)
      end
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter-context",
    after = "nvim-treesitter",
    event = "BufRead",
  },
  {
    "echasnovski/mini.nvim",
    version = false,
    event = "VeryLazy",
    config = function()
      -- require("mini.ai").setup()
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
    "mattn/emmet-vim",
    ft = { "html", "css", "javascript", "javascriptreact", "typescript", "typescriptreact", "xml" },
  },
}

return plugins
