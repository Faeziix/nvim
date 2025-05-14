local M = {}

M.disabled = {
  n = {},
}

M.general = {
  n = {
    ["<Tab>"] = { "%", "Go to other pair" },
    ["<leader>x"] = { ":bd<CR>", "Close the buffer" },

    ["n"] = { "nzz", "Go to next and center" },
    ["N"] = { "Nzz", "Go to next and center" },
    ["<C-u>"] = { "<C-u>zz", "Go half page up" },
    ["<C-d>"] = { "<C-d>zz", "Go half page down" },
    ["<C-f>"] = { "<C-f>zz", "Go full page up" },
    ["<C-b>"] = { "<C-b>zz", "Go full page down" },

    ["<leader>q"] = { ":q<CR>" },
    ["<leader>A"] = {
      function()
        require("custom.function.toggle_qf").toggle_qf()
      end,
    },
    ["<leader><leader>"] = { ":w<CR>" },
    ["<leader>e"] = { "<cmd> NvimTreeToggle <CR>", "Toggle nvimtree" },
  },
  o = {
    ["<Tab>"] = { "%", "Go to other pair" },
  },
  x = {
    ["<Tab>"] = { "%", "Go to other pair" },
  },
  v = {
    ["<Tab>"] = { "%", "Go to other pair" },
  },
}

M.nvterm = {
  n = {
    ["<A-t>"] = {
      function()
        require("nvterm.terminal").toggle "horizontal"
      end,
      "Toggle horizontal term",
    },
  },
  t = {
    ["<A-t>"] = {
      function()
        require("nvterm.terminal").toggle "horizontal"
      end,
      "Toggle horizontal term",
    },
  },
}

return M
