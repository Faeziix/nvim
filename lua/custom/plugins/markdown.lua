return {
  {
    {
      "iamcco/markdown-preview.nvim",
      ft = "markdown",
      cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
      build = function()
        vim.fn["mkdp#util#install"]()
      end,
    },
  },
  {
    "MeanderingProgrammer/render-markdown.nvim",
    ft = { "markdown", "mdx", "vimwiki" },
    dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-mini/mini.nvim" },
    opts = {},
    config = function(_, opts)
      require("render-markdown").setup(opts)

      -- Helper functions for color blending
      local function hex_to_rgb(h)
        h = h:gsub("#", "")
        return tonumber(h:sub(1, 2), 16), tonumber(h:sub(3, 4), 16), tonumber(h:sub(5, 6), 16)
      end

      local function rgb_to_hex(r, g, b)
        return string.format("#%02x%02x%02x", r, g, b)
      end

      local function blend(fg, bg, a)
        local fr, fgc, fb = hex_to_rgb(fg)
        local br, bgc, bb = hex_to_rgb(bg)
        return rgb_to_hex(
          math.floor(fr * a + br * (1 - a) + 0.5),
          math.floor(fgc * a + bgc * (1 - a) + 0.5),
          math.floor(fb * a + bb * (1 - a) + 0.5)
        )
      end

      -- Main function to set up heading colors
      local function apply_heading_colors()
        -- Get Tokyonight palette with safe fallback
        local ok, tn = pcall(require, "tokyonight.colors")
        local C = ok and tn.setup {}
          or {
            bg = "#1a1b26",
            blue = "#7aa2f7",
            cyan = "#7dcfff",
            green = "#9ece6a",
            yellow = "#e0af68",
            magenta = "#bb9af7",
            orange = "#ff9e64",
            red = "#f7768e",
            fg = "#c0caf5",
          }

        -- Define accent colors for each heading level (H1-H6)
        -- Option 1: Vibrant gradient from warm to cool
        -- local accents = { C.magenta, C.blue, C.cyan, C.green, C.yellow, C.orange or C.red }

        -- Option 2: Ocean theme (uncomment to use)
        -- local accents = { "#89ddff", "#82aaff", "#7aa2f7", "#7dcfff", "#73daca", "#9ece6a" }

        -- Option 3: Sunset theme (uncomment to use)
        local accents = { "#ff9e64", "#ff7a85", "#9ece6a", "#f7768e", "#c678dd", "#bb9af7" }

        -- Option 4: Monochrome blue (uncomment to use)
        -- local accents = { "#7aa2f7", "#82aaff", "#89b4fa", "#89ddff", "#7dcfff", "#86e1fc" }

        -- Background alpha values (tweak these for stronger/weaker bg stripes)
        local alphas = { 0.20, 0.16, 0.12, 0.10, 0.08, 0.06 }

        local bg_base = C.bg or "#1a1b26"

        -- Set up RenderMarkdownH{N} and RenderMarkdownH{N}Bg groups
        for i = 1, 6 do
          local accent = accents[i]
          local alpha = alphas[i]

          -- Text foreground with bold
          vim.api.nvim_set_hl(0, ("RenderMarkdownH%d"):format(i), {
            fg = accent,
            bold = true,
            nocombine = true,
          })

          -- Background stripe
          vim.api.nvim_set_hl(0, ("RenderMarkdownH%dBg"):format(i), {
            bg = blend(accent, bg_base, alpha),
          })
        end

        -- Link Treesitter captures to our RenderMarkdown groups
        -- This ensures our fg always wins over Tokyonight's @markup.heading
        local captures_to_link = {
          -- Standard markdown
          "@markup.heading.1.markdown",
          "@markup.heading.2.markdown",
          "@markup.heading.3.markdown",
          "@markup.heading.4.markdown",
          "@markup.heading.5.markdown",
          "@markup.heading.6.markdown",
          -- MDX support
          "@markup.heading.1.mdx",
          "@markup.heading.2.mdx",
          "@markup.heading.3.mdx",
          "@markup.heading.4.mdx",
          "@markup.heading.5.mdx",
          "@markup.heading.6.mdx",
          -- Vimwiki (registered as markdown)
          "@markup.heading.1.vimwiki",
          "@markup.heading.2.vimwiki",
          "@markup.heading.3.vimwiki",
          "@markup.heading.4.vimwiki",
          "@markup.heading.5.vimwiki",
          "@markup.heading.6.vimwiki",
        }

        for _, capture in ipairs(captures_to_link) do
          local level = capture:match "%.(%d)%."
          if level then
            vim.api.nvim_set_hl(0, capture, { link = ("RenderMarkdownH%s"):format(level) })
          end
        end

        -- Also link the generic @markup.heading to maintain consistency
        vim.api.nvim_set_hl(0, "@markup.heading", { link = "RenderMarkdownH1" })

        -- Clear the marker (###) foreground so it doesn't interfere
        vim.api.nvim_set_hl(0, "@markup.heading.marker.markdown", { fg = "NONE" })
        vim.api.nvim_set_hl(0, "@markup.heading.marker.mdx", { fg = "NONE" })
      end

      -- Apply colors now
      vim.schedule(apply_heading_colors)

      -- Reapply on ColorScheme changes (when switching themes/styles)
      vim.api.nvim_create_autocmd("ColorScheme", {
        pattern = "*",
        callback = apply_heading_colors,
        desc = "Reapply render-markdown heading colors after colorscheme change",
      })

      -- Also reapply for markdown/mdx/vimwiki buffers to ensure consistency
      vim.api.nvim_create_autocmd({ "FileType", "BufEnter" }, {
        pattern = { "markdown", "mdx", "vimwiki" },
        callback = function()
          vim.schedule(apply_heading_colors)
        end,
        desc = "Ensure render-markdown heading colors are applied in markdown buffers",
      })
    end,
  },
  {
    "vimwiki/vimwiki",
    lazy = false,
    init = function()
      vim.g.vimwiki_ext2syntax = {
        [".md"] = "markdown",
      }
      vim.g.vimwiki_list = { { path = "~/vimwiki", syntax = "markdown", ext = ".md" } }
      vim.g.vimwiki_global_ext = 0
      vim.treesitter.language.register("markdown", "vimwiki")
    end,
  },
  {
    "nvim-treesitter/playground",
    lazy = false,
  },
}
