---@type ChadrcConfig
local M = {}

M.ui = {
  theme = "rxyhn",
  transparency = true,
  hl_override = {
    CursorLine = {
      bg = "#181818",
    },
    Visual = {
      bg = "#444444",
    },
    IndentBlanklineContextChar = {
      fg = "#4b5263",
    },
    IndentBlanklineContextStart = {
      bg = "#2f2f2f",
    },
    Comment = {
      fg = "#777777",
    },
    LineNr = {
      -- fg = "#6b7273",
    },
  },
}

-- M.options = require "custom.options"

M.plugins = "custom.plugins"
M.mappings = require "custom.mappings"

return M
