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
      },
    },
    {
      "williamboman/mason-lspconfig.nvim",
      dependencies = { "williamboman/mason.nvim" },
    },
  },
  config = function()
    -- NvChad's base lsp setup: base46 highlights, nvchad.lsp, on_attach, lua_ls
    require "plugins.configs.lspconfig"

    -- Applied to every server; per-server tables below are deep-merged on top.
    vim.lsp.config("*", {
      capabilities = require("cmp_nvim_lsp").default_capabilities(),
    })

    vim.lsp.config("ts_ls", {
      settings = {
        completions = {
          completeFunctionCalls = true,
        },
      },
    })

    vim.lsp.config("tailwindcss", {
      settings = {
        tailwindCSS = {
          experimental = {
            classRegex = {
              { "cva\\(([^)]*)\\)", "[\"'`]([^\"'`]*).*?[\"'`]" },
              { "cx\\(([^)]*)\\)", "(?:'|\"|`)([^']*)(?:'|\"|`)" },
            },
          },
        },
      },
    })

    vim.lsp.config("rust_analyzer", {
      settings = {
        ["rust-analyzer"] = {
          imports = {
            granularity = {
              group = "module",
            },
            prefix = "self",
          },
          cargo = {
            buildScripts = {
              enable = true,
            },
          },
          procMacro = {
            enable = true,
          },
        },
      },
    })

    vim.lsp.config("vue_ls", {
      init_options = {
        vue = {
          hybridMode = false,
        },
      },
      settings = {
        typescript = {
          inlayHints = {
            enumMemberValues = { enabled = true },
            functionLikeReturnTypes = { enabled = true },
            propertyDeclarationTypes = { enabled = true },
            parameterTypes = { enabled = true, suppressWhenArgumentMatchesName = true },
            variableTypes = { enabled = true },
          },
        },
      },
    })

    -- Installed servers are enabled automatically (mason-lspconfig `automatic_enable`).
    require("mason-lspconfig").setup {
      ensure_installed = {
        "ts_ls",
        "eslint",
        "html",
        "cssls",
        "pyright",
        "rust_analyzer",
      },
      automatic_enable = {
        -- stylua ships an `--lsp` mode that mason-lspconfig would enable as a
        -- formatting-only client; conform.nvim already runs stylua for lua.
        exclude = { "stylua" },
      },
    }

    vim.api.nvim_create_autocmd("LspAttach", {
      desc = "LSP actions",
      callback = function(event)
        local opts = { buffer = event.buf }
        vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
        vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
        vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
        vim.keymap.set("n", "go", vim.lsp.buf.type_definition, opts)
        vim.keymap.set("n", "gr", require("telescope.builtin").lsp_references, opts)
        vim.keymap.set("n", "gs", vim.lsp.buf.signature_help, opts)
        vim.keymap.set("n", "<F2>", vim.lsp.buf.rename, opts)
        vim.keymap.set({ "n", "x" }, "<F3>", function()
          vim.lsp.buf.format { async = true }
        end, opts)
        vim.keymap.set("n", "<F4>", vim.lsp.buf.code_action, opts)
        vim.keymap.set("n", "gl", vim.diagnostic.open_float, opts)
        vim.keymap.set("n", "[d", function()
          vim.diagnostic.jump { count = -1, float = { border = "rounded" }, severity = { min = vim.diagnostic.severity.WARN } }
        end, opts)
        vim.keymap.set("n", "]d", function()
          vim.diagnostic.jump { count = 1, float = { border = "rounded" }, severity = { min = vim.diagnostic.severity.WARN } }
        end, opts)

        local client = vim.lsp.get_client_by_id(event.data.client_id)
        if client then
          client.server_capabilities.semanticTokensProvider = nil
        end
      end,
    })

    vim.lsp.protocol.CompletionItemKind = {
      "   (Text) ",
      "   (Method)",
      " 󰊕  (Function)",
      "   (Constructor)",
      "   (Field)",
      " 󰫧  (Variable)",
      " 󰌗  (Class)",
      " 󰛀  (Interface)",
      " 󰅩  (Module)",
      " 󰖷  (Property)",
      "   (Unit)",
      " 󰇼  (Value)",
      "   (Enum)",
      "   (Keyword)",
      "   (Snippet)",
      "   (Color)",
      "   (File)",
      "   (Reference)",
      " 󰉋  (Folder)",
      "   (EnumMember)",
      " 󰞂  (Constant)",
      " 󰟦  (Struct)",
      "   (Event)",
      " 󰃬  (Operator)",
      " 󰊄  (TypeParameter)",
    }

    vim.diagnostic.config {
      virtual_text = false,
      severity_sort = true,
      signs = {
        text = {
          [vim.diagnostic.severity.ERROR] = "󰅚 ",
          [vim.diagnostic.severity.WARN] = " ",
          [vim.diagnostic.severity.HINT] = "󰌶 ",
          [vim.diagnostic.severity.INFO] = " ",
        },
      },
      float = {
        border = "rounded",
        source = true,
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
}
