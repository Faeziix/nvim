return {
  "ThePrimeagen/harpoon",
  keys = { "<A-1>", "<A-2>", "<A-3>", "<A-4>", "<A-a>", "<A-S-h>" },
  event = "VeryLazy",
  init = function()
    require("harpoon").setup {}

    local map = require "custom.mappings"
    map.harpoon = {
      n = {
        ["<A-a>"] = {
          function()
            require("harpoon.mark").add_file()
          end,
          "Add file to Harpoon",
        },
        ["<A-S-h>"] = {
          function()
            require("harpoon.ui").toggle_quick_menu()
          end,
          "Toggle Harpoon Aenu",
        },
        ["<A-1>"] = {
          function()
            require("harpoon.ui").nav_file(1)
          end,
          "Goto Buffer 1",
        },
        ["<A-2>"] = {
          function()
            require("harpoon.ui").nav_file(2)
          end,
          "Goto Buffer 2",
        },
        ["<A-3>"] = {
          function()
            require("harpoon.ui").nav_file(3)
          end,
          "Goto Buffer 3",
        },
        ["<A-4>"] = {
          function()
            require("harpoon.ui").nav_file(4)
          end,
          "Goto Buffer 4",
        },
        ["<A-5>"] = {
          function()
            require("harpoon.ui").nav_file(5)
          end,
          "Goto Buffer 4",
        },
      },
    }
  end,
}
