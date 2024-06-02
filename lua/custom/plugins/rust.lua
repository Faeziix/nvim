return {
  {
    "simrat39/rust-tools.nvim",
    ft = "rust",
    dependencies = "neovim/nvim-lspconfig",
    opts = {
      tools = {
        inlay_hints = {
          show_parameter_hints = true,
          parameter_hints_prefix = " ",
          other_hints_prefix = " ",
        },
      },
      server = {
        on_attach = require("plugins.configs.lspconfig").on_attach,
        capabilities = require("plugins.configs.lspconfig").capabilities,
      },
    },
  },
  {
    "saecki/crates.nvim",
    ft = "rust",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("crates").setup()
    end,
  }
}
