local au = function(events, ptn, cb)
  vim.api.nvim_create_autocmd(events, { pattern = ptn, [type(cb) == "function" and "callback" or "command"] = cb })
end

vim.api.nvim_create_autocmd("LspAttach", {
  desc = "LSP actions",
  callback = function(event)
    local opts = { buffer = event.buf }
    vim.keymap.set("n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>", opts)
    vim.keymap.set("n", "gd", "<cmd>lua vim.lsp.buf.definition()<cr>", opts)
    vim.keymap.set("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<cr>", opts)
    vim.keymap.set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<cr>", opts)
    vim.keymap.set("n", "go", "<cmd>lua vim.lsp.buf.type_definition()<cr>", opts)
    vim.keymap.set("n", "gr", "<cmd>lua vim.lsp.buf.references()<cr>", opts)
    vim.keymap.set("n", "gs", "<cmd>lua vim.lsp.buf.signature_help()<cr>", opts)
    vim.keymap.set("n", "<F2>", "<cmd>lua vim.lsp.buf.rename()<cr>", opts)
    vim.keymap.set({ "n", "x" }, "<F3>", "<cmd>lua vim.lsp.buf.format({async = true})<cr>", opts)
    vim.keymap.set("n", "<F4>", "<cmd>lua vim.lsp.buf.code_action()<cr>", opts)
    vim.keymap.set("n", "gl", "<cmd>lua vim.diagnostic.open_float()<cr>", opts)
    vim.keymap.set("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<cr>", opts)
    vim.keymap.set("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<cr>", opts)
    vim.keymap.set("n", "<leader>ds", "<cmd>lua vim.diagnostic.show_line_diagnostics()<cr>", opts)
    vim.keymap.set("n", "<leader>dl", "<cmd>lua vim.diagnostic.setloclist()<cr>", opts)
    vim.keymap.set("n", "<leader>do", "<cmd>lua vim.diagnostic.open_float(0, { scope = 'line' })<cr>", opts)
    vim.keymap.set("n", "<leader>dw", "<cmd>lua vim.diagnostic.setqflist()<cr>", opts)
  end,
})

return {
  {
    "VonHeikemen/lsp-zero.nvim",
    dependencies = {
      {
        "williamboman/mason.nvim",
        opts = {
          ensure_installed = {
            "rust_analyzer",
            "tsserver",
            "css-lsp",
            "jsonls",
            "pyright",
            "vim-language-server",
          },
          automatic_installation = true,
        },
      },
      "neovim/nvim-lspconfig",
      "williamboman/mason-lspconfig.nvim",
      "hrsh7th/nvim-cmp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "saadparwaiz1/cmp_luasnip",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-nvim-lua",
      "L3MON4D3/LuaSnip",
      "rafamadriz/friendly-snippets",
      { "lukas-reineke/lsp-format.nvim", config = true },
    },
    init = function()
      local lsp_zero = require "lsp-zero"
      lsp_zero.extend_lspconfig()

      lsp_zero.on_attach(function(client, bufnr)
        lsp_zero.default_keymaps { buffer = bufnr }
      end)

      require("mason").setup {}
      require("mason-lspconfig").setup {
        handlers = {
          lsp_zero.default_setup,
        },
      }

      au("LspAttach", "*", function(a)
        vim.lsp.get_client_by_id(a.data.client_id).server_capabilities.semanticTokensProvider = nil
      end)

      vim.lsp.protocol.CompletionItemKind = {
        "   (Text) ",
        "   (Method)",
        "   (Function)",
        "   (Constructor)",
        " ﴲ  (Field)",
        "[] (Variable)",
        "   (Class)",
        " ﰮ  (Interface)",
        "   (Module)",
        " 襁 (Property)",
        "   (Unit)",
        "   (Value)",
        " 練 (Enum)",
        "   (Keyword)",
        "   (Snippet)",
        "   (Color)",
        "   (File)",
        "   (Reference)",
        "   (Folder)",
        "   (EnumMember)",
        " ﲀ  (Constant)",
        " ﳤ  (Struct)",
        "   (Event)",
        "   (Operator)",
        "   (TypeParameter)",
      }

      local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
      for type, icon in pairs(signs) do
        local hl = "DiagnosticSign" .. type
        vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
      end

      vim.diagnostic.config {
        virtual_text = false,
        severity_sort = true,
        float = {
          border = "rounded",
          source = "always",
          header = "",
          prefix = "",
        },
      }
    end,
  },
}
