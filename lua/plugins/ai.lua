return {
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    build = ":Copilot auth",
    event = "InsertEnter",
    config = function()
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
        },
      }
    end,
  },
  -- {
  --   "Exafunction/codeium.vim",
  --   event = "InsertEnter",
  --   config = function()
  --     vim.keymap.set("i", "<C-k>", function()
  --       return vim.fn["codeium#Accept"]()
  --     end, { expr = true, silent = true })
  --   end,
  -- },
  -- {
  --   "supermaven-inc/supermaven-nvim",
  --   event = "BufRead",
  --   opts = {
  --     keymaps = {
  --       accept_suggestion = "<C-K>",
  --       clear_suggestion = "<C-]>",
  --       accept_word = "<C-J>",
  --     },
  --   },
  -- },
}
