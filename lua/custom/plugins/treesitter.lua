return {
  {
    "nvim-treesitter/nvim-treesitter-context",
    after = "nvim-treesitter",
    -- event = "BufRead",
  },
  {
    "nvim-treesitter/nvim-treesitter",
    init = function()
      require("core.utils").lazy_load "nvim-treesitter"
    end,
    cmd = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSModuleInfo" },
    build = ":TSUpdate",
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
    },
    opts = {
      ensure_installed = {
        "lua",
        "bash",
        "json",
        "markdown",
        "markdown_inline",
        "html",
        "css",
        "javascript",
        "typescript",
        "tsx",
        "liquid",
      },
      ignore_install = { "org" },
      auto_install = true,
      highlight = {
        enable = true,
        use_languagetree = true,
      },
      indent = { enable = true },
      textobjects = {
        select = {
          enable = true,
          lookahead = true,
          keymaps = {
            -- You can use the capture groups defined in textobjects.scm
            ["af"] = "@function.outer",
            ["if"] = "@function.inner",
            ["ac"] = "@class.outer",
            ["ic"] = "@class.inner",
          },
        },
      },
      rainbow = { enable = true, extended_mode = true, max_file_lines = 1000 },
    },
    config = function(_, opts)
      dofile(vim.g.base46_cache .. "syntax")

      -- Neovim 0.12 removed the legacy `all = false` mode of Query:iter_matches, so
      -- `match[id]` is now always a LIST of nodes ({node}) instead of a single node.
      -- nvim-treesitter's (deprecated) master branch still assumes a single node, so
      -- textobjects (af/if/ac/ic, e.g. `yaf`) crash in TSRange.from_nodes with
      -- "attempt to call method 'start' (a nil value)". Re-implement iter_prepared_matches
      -- here, normalizing each capture's list back to its first node. Lives in our own
      -- config so it survives `:Lazy update` and is trivially removable once we move to
      -- the nvim-treesitter `main` branch.
      local q = require "nvim-treesitter.query"
      local tsrange = require "nvim-treesitter.tsrange"
      local function node_of(v) -- {node,...} -> node ; node -> node ; nil -> nil
        if type(v) == "table" then return v[1] end
        return v
      end
      local function split(s)
        local t = {}
        for str in string.gmatch(s, "([^.]+)") do t[#t + 1] = str end
        return t
      end
      q.iter_prepared_matches = function(query, qnode, bufnr, start_row, end_row)
        local matches = query:iter_matches(qnode, bufnr, start_row, end_row)
        return function()
          local pattern, match, metadata = matches()
          if pattern == nil then return end
          local prepared = {}
          for id, nodes in pairs(match) do
            local name = query.captures[id]
            if name ~= nil then
              q.insert_to_path(prepared, split(name .. ".node"), node_of(nodes))
              q.insert_to_path(prepared, split(name .. ".metadata"), metadata[id])
            end
          end
          local preds = query.info.patterns[pattern]
          if preds then
            for _, pred in pairs(preds) do
              if pred[1] == "set!" and type(pred[2]) == "string" then
                q.insert_to_path(prepared, split(pred[2]), pred[3])
              end
              if pred[1] == "make-range!" and type(pred[2]) == "string" and #pred == 4 then
                q.insert_to_path(prepared, split(pred[2] .. ".node"),
                  tsrange.TSRange.from_nodes(bufnr, node_of(match[pred[3]]), node_of(match[pred[4]])))
              end
            end
          end
          return prepared
        end
      end

      require("nvim-treesitter.configs").setup(opts)

      vim.filetype.add {
        extension = {
          mdx = "mdx",
        },
      }
      vim.treesitter.language.register("markdown", "mdx")
    end,
  },
}
