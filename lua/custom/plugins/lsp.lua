return {
  {
    {
      "neovim/nvim-lspconfig",
      -- rm_default_opts = true,
      dependencies = {
        {
          "williamboman/mason-lspconfig.nvim",
        },
        {
          "williamboman/mason.nvim",
          -- rm_default_opts = true,
          opts = {

            ensure_installed = {
              "rust_analyzer",
              "tsserver",
            },
            automatic_installation = true,
            -- handlers = {
            --   lsp_zero.default_setup,
            -- },
          },
        },
      },
      config = function()
        local lsp_zero = require "lsp_zero"

        lsp_zero.on_attach(function(client, bufnr)
          lsp_zero.default_keymaps { buffer = bufnr }
        end)

        require("mason-lspconfig").setup {}

        local au = function(events, ptn, cb)
          vim.api.nvim_create_autocmd(
            events,
            { pattern = ptn, [type(cb) == "function" and "callback" or "command"] = cb }
          )
        end

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
      init = function()
        local map = require "custom.mappings"
        map.lsp = {
          n = {
            ["K"] = { "<cmd>lua vim.lsp.buf.hover()<cr>", "Hover Doc" },
            ["<leader>ds"] = { "<cmd>lua vim.diagnostic.show_line_diagnostics()<cr>", "Show line diagnostics" },
            ["<leader>dl"] = { "<cmd>lua vim.diagnostic.setloclist()<cr>", "Set loclist" },
            ["<leader>do"] = { "<cmd>lua vim.diagnostic.open_float(0, { scope = 'line' })<cr>", "Open diagnostic" },
            ["<leader>dw"] = { "<cmd>lua vim.diagnostic.setqflist()<cr>", "Set qflist" },
            ["gd"] = { "<cmd>lua vim.lsp.buf.definition()<cr>", "Go to definition" },
            ["gD"] = { "<cmd>lua vim.lsp.buf.declaration()<cr>", "Go to declaration" },
            ["gi"] = { "<cmd>lua vim.lsp.buf.implementation()<cr>", "Go to implementation" },
            ["go"] = { "<cmd>lua vim.lsp.buf.type_definition()<cr>", "Go to type definition" },
            ["gr"] = { "<cmd>lua vim.lsp.buf.references()<cr>", "Go to references" },
            ["gs"] = { "<cmd>lua vim.lsp.buf.signature_help()<cr>", "Signature Help" },
            ["<F2>"] = { "<cmd>lua vim.lsp.buf.rename()<cr>", "Rename" },
            ["<F3>"] = { "<cmd>lua vim.lsp.buf.format({async = true})<cr>", "Format the file (Async)" },
            ["<F4>"] = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "Code Action" },
            ["gl"] = { "<cmd>lua vim.diagnostic.open_float()<cr>", "Open floating menu" },
            ["[d"] = { "<cmd>lua vim.diagnostic.goto_prev()<cr>", "Go to next diagnostic" },
            ["]d"] = { "<cmd>lua vim.diagnostic.goto_next()<cr>", "Go to prev diagnostic" },
          },
          x = {
            ["<F3>"] = { "<cmd>lua vim.lsp.buf.format({async = true})<cr>", "" },
          },
        }
      end,
    },
  },
}
