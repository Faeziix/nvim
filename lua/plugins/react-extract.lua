return {
  "napmn/react-extract.nvim",
  ft = { "javascript", "typescript", "javascriptreact", "typescriptreact" },
  config = function()
    require("react-extract").setup()
  end,
  init = function()
    local map = require "custom.mappings"

    map.extract = {
      v = {
        ["<leader>rn"] = { require("react-extract").extract_to_new_file, "Extract to New File" },
        ["<leader>rc"] = { require("react-extract").extract_to_current_file, "Extract to Current File" },
      },
    }
  end,
}
