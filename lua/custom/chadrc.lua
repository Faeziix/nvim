---@type ChadrcConfig
local M = {}

M.ui = {
  theme = "tokyonight",
  transparency = true,
  hl_override = {
    CursorLine = {
      bg = "black"
    },
    ["@comment"] = {
      fg = "light_grey",
    },
    Visual = {
      bg = "grey"
    },
    LineNr = {
      fg = "#6f7273",
    },
    ["@markup.italic"] = {
      fg = "cyan",
    },
    ["@markup.strong"] = {
      fg = "blue",
    },
    ["@markup.heading"] = {
      fg = "yellow",
      bg = "none",
    },
  },
}

M.plugins = "custom.plugins"
M.mappings = require "custom.mappings"

return M
