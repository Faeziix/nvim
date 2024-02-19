local au = function(events, ptn, cb)
  vim.api.nvim_create_autocmd(events, { pattern = ptn, [type(cb) == "function" and "callback" or "command"] = cb })
end

return {
  "neovim/nvim-lspconfig",
  event = "BufReadPre",
  dependencies = {
    {
      "williamboman/mason.nvim",
      opts = {
        ensure_installed = {
          "python-lsp-server",
          "lua-language-server",
          "rust-analyzer",
          "omnisharp",
          "typescript-language-server",
          "css-lsp",
          "html-lsp",
          "prettier",
          "stylua",
          "black",
          "php-cs-fixer",
          "debugpy",
          "tailwindcss-language-server",
        },
        automatic_installation = true,
      },
    },
    {
      "williamboman/mason-lspconfig.nvim",
      dependencies = { "williamboman/mason.nvim" },
    },
  },
  config = function()
    local lspconfig = require "lspconfig"
    local lsp_capabilities = require("cmp_nvim_lsp").default_capabilities()

    require("mason").setup {}
    require("mason-lspconfig").setup {
      ensure_installed = {
        "tsserver",
        "eslint",
        "html",
        "cssls",
        "pyright",
      },
      handlers = {
        function(server)
          lspconfig[server].setup {
            capabilities = lsp_capabilities,
          }
        end,
        ["lua_ls"] = function()
          lspconfig.lua_ls.setup {
            settings = {
              Lua = {
                diagnostics = {
                  globals = { "vim" },
                },
              },
            },
          }
        end,
        ["tsserver"] = function()
          lspconfig.tsserver.setup {
            capabilities = lsp_capabilities,
            settings = {
              completions = {
                completeFunctionCalls = true,
              },
            },
          }
        end,
        ["tailwindcss"] = function()
          lspconfig.tailwindcss.setup {
            settings = {
              tailwindCSS = {
                experimental = {
                  classRegex = {
                    ".*style",
                  },
                },
              },
            },
          }
        end,
      },
    }

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
        vim.keymap.set("n", "[d",
          "<cmd>lua vim.diagnostic.goto_prev{ float = { border = \"rounded\" }, severity = { min = vim.diagnostic.severity.WARN } }<cr>",
          opts)
        vim.keymap.set("n", "]d",
          "<cmd>lua vim.diagnostic.goto_next{ float = { border = \"rounded\" }, severity = { min = vim.diagnostic.severity.WARN } }<cr>",
          opts)
      end,
    })

    au("LspAttach", "*", function(a)
      vim.lsp.get_client_by_id(a.data.client_id).server_capabilities.semanticTokensProvider = nil
    end)

    vim.lsp.protocol.CompletionItemKind = {
      "   (Text) ",
      "   (Method)",
      " 󰊕  (Function)",
      "   (Constructor)",
      "   (Field)",
      " 󰫧  (Variable)",
      " 󰌗  (Class)",
      " 󰛀  (Interface)",
      " 󰅩  (Module)",
      " 󰖷  (Property)",
      "   (Unit)",
      " 󰇼  (Value)",
      "   (Enum)",
      "   (Keyword)",
      "   (Snippet)",
      "   (Color)",
      "   (File)",
      "   (Reference)",
      " 󰉋  (Folder)",
      "   (EnumMember)",
      " 󰞂  (Constant)",
      " 󰟦  (Struct)",
      "   (Event)",
      " 󰃬  (Operator)",
      " 󰊄  (TypeParameter)",
    }

    local signs = { Error = "󰅚 ", Warn = " ", Hint = "󰌶 ", Info = " " }
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
        severity_sort = true,
        header = "",
        prefix = "",
      },
    }

    local function border(hl_name)
      return {
        { "╭", hl_name },
        { "─", hl_name },
        { "╮", hl_name },
        { "│", hl_name },
        { "╯", hl_name },
        { "─", hl_name },
        { "╰", hl_name },
        { "│", hl_name },
      }
    end

    local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
    function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
      opts = opts or {}
      opts.border = opts.border or border "FloatBorder"
      return orig_util_open_floating_preview(contents, syntax, opts, ...)
    end
  end,
  -- init = function()
  --   local map = require "custom.mappings"
  --   map.lsp = {
  --     n = {
  --       ["K"] = { "<cmd>lua vim.lsp.buf.hover()<cr>", "Hover Doc" },
  --       ["<leader>ds"] = { "<cmd>lua vim.diagnostic.show_line_diagnostics()<cr>", "Show line diagnostics" },
  --       ["<leader>dl"] = { "<cmd>lua vim.diagnostic.setloclist()<cr>", "Set loclist" },
  --       ["<leader>do"] = { "<cmd>lua vim.diagnostic.open_float(0, { scope = 'line' })<cr>", "Open diagnostic" },
  --       ["<leader>dw"] = { "<cmd>lua vim.diagnostic.setqflist()<cr>", "Set qflist" },
  --       ["gd"] = { "<cmd>lua vim.lsp.buf.definition()<cr>", "Go to definition" },
  --       ["gD"] = { "<cmd>lua vim.lsp.buf.declaration()<cr>", "Go to declaration" },
  --       ["gi"] = { "<cmd>lua vim.lsp.buf.implementation()<cr>", "Go to implementation" },
  --       ["go"] = { "<cmd>lua vim.lsp.buf.type_definition()<cr>", "Go to type definition" },
  --       ["gr"] = { "<cmd>lua vim.lsp.buf.references()<cr>", "Go to references" },
  --       ["gs"] = { "<cmd>lua vim.lsp.buf.signature_help()<cr>", "Signature Help" },
  --       ["<F2>"] = { "<cmd>lua vim.lsp.buf.rename()<cr>", "Rename" },
  --       ["<F3>"] = { "<cmd>lua vim.lsp.buf.format({async = true})<cr>", "Format the file (Async)" },
  --       ["<F4>"] = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "Code Action" },
  --       ["gl"] = { "<cmd>lua vim.diagnostic.open_float()<cr>", "Open floating menu" },
  --       ["[d"] = { "<cmd>lua vim.diagnostic.goto_prev()<cr>", "Go to next diagnostic" },
  --       ["]d"] = { "<cmd>lua vim.diagnostic.goto_next()<cr>", "Go to prev diagnostic" },
  --     },
  --     x = {
  --       ["<F3>"] = { "<cmd>lua vim.lsp.buf.format({async = true})<cr>", "" },
  --     },
  --   }
  -- end,
}
