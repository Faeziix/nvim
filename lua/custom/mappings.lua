local M = {}

M.disabled = { n = {} }

M.general = {
  n = {
    ["<Tab>"] = { "%", "Go to other pair" },
    ["<leader>x"] = { ":bd<CR>", "Close the buffer" },

    ["n"] = { "nzz", "Go to next and center" },
    ["<C-u>"] = { "<C-u>zz", "Go half page up" },
    ["<C-d>"] = { "<C-d>zz", "Go half page down" },
    ["<C-f>"] = { "<C-f>zz", "Go full page up" },
    ["<C-b>"] = { "<C-b>zz", "Go full page down" },

    ["<leader>q"] = { ":q<CR>" },
    ["<leader><leader>"] = { ":w<CR>" },
    ["<leader>tt"] = {
      function()
        require("base46").toggle_transparency()
      end,
      "toggle transparency",
    },
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
  i = {
    ["<Tab>"] = { "<Tab>", "Indent" },

    ["<C-k>"] = {
      function()
        vim.fn.feedkeys(vim.fn["copilot#Accept"](), "")
      end,
      "Copilot Accept",
      { replace_keycodes = true, nowait = true, silent = true, expr = true, noremap = true },
    },
  },
}

M.tabufline = {
  n = {
    ["<A-l>"] = {
      function()
        require("nvchad.tabufline").tabuflineNext()
      end,
      "Goto next buffer",
    },

    ["<A-h>"] = {
      function()
        require("nvchad.tabufline").tabuflinePrev()
      end,
      "Goto prev buffer",
    },
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

M.telescope = {
  n = {
    ["<leader>F"] = { "<cmd> Telescope recents <CR>", "Find files" },
    -- ["<leader>F"] = {
    --   function()
    --     local cmd = "git ls-files --full-name -z | xargs -0 -I{} -- stat -c'%Y %n' {} | sort -k1,1nr | cut -d' ' -f2-"
    --     require("telescope.builtin").find_files {
    --       prompt_title = "Git Files",
    --       find_command = { "sh", "-c", cmd },
    --     }
    --   end,
    --   "Find Git files",
    -- },
  },
}

return M
