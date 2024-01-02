local present, null_ls = pcall(require, "null-ls")

if not present then
  return
end

local b = null_ls.builtins

local sources = {

  -- formats markdown, json, yaml
  b.formatting.prettierd,
  b.diagnostics.markdownlint,

  -- Python
  b.formatting.isort,
  -- Lua
  b.formatting.stylua,

  -- Shell
  b.formatting.shfmt,
  b.diagnostics.shellcheck.with { diagnostics_format = "#{m} [#{c}]" },

  -- Rust
  b.formatting.rustfmt,
}

null_ls.setup {
  debug = true,
  sources = sources,
  -- on_attach = function()
  --   vim.api.nvim_create_autocmd("BufWritePost", {
  --     callback = function()
  --       vim.lsp.buf.format()
  --     end,
  --   })
  -- end,
}
