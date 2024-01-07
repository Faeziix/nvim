return {
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    build = ":Copilot auth",
    event = "InsertEnter",
    config = function()
      -- vim.g.copilot_no_tab_map = true
      -- vim.g.copilot_assume_mapped = true
      -- vim.g.copilot_tab_fallback = "<C-k>"
      require("copilot").setup {
        panel = {
          enabled = true,
          auto_refresh = true,
        },
        suggestion = {
          enabled = true,
          auto_trigger = true,
          keymap = {
            accept = "<C-k>",
          },
          -- accept = false, -- disable built-in keymapping
        },
      }

      -- hide copilot suggestions when cmp menu is open
      -- to prevent odd behavior/garbled up suggestions
      -- local cmp_status_ok, cmp = pcall(require, "cmp")
      -- if cmp_status_ok then
      --   cmp.event:on("menu_opened", function()
      --     vim.b.copilot_suggestion_hidden = true
      --   end)
      --
      --   cmp.event:on("menu_closed", function()
      --     vim.b.copilot_suggestion_hidden = false
      --   end)
      -- end
    end,
  },

  { "David-Kunz/gen.nvim" },
}
