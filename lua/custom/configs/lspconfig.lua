local lsp_zero = require "lsp-zero"
local lspconfig = require "lspconfig"
local mason = require "mason"

lsp_zero.on_attach(function(client, bufnr)
  lsp_zero.default_keymaps { buffer = bufnr }
end)

mason.setup {}
require("mason-lspconfig").setup {
  ensure_installed = {
    "rust_analyzer",
    "tsserver",
  },
  automatic_installation = true,
  handlers = {
    lsp_zero.default_setup,
  },
}

local au = function(events, ptn, cb)
  vim.api.nvim_create_autocmd(events, { pattern = ptn, [type(cb) == "function" and "callback" or "command"] = cb })
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
