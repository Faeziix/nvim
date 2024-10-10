return {
  {
    'nvim-orgmode/orgmode',
    event = 'VeryLazy',
    ft = { 'org' },
    config = function()
      -- Setup orgmode
      require('orgmode').setup({
        org_agenda_files = '~/orgfiles/**/*',
        org_default_notes_file = '~/orgfiles/refile.org',
      })
    end,
  },
  {
    'akinsho/org-bullets.nvim',
    after = 'orgmode',
    ft = { 'org' },
    config = function(opts)
      require('org-bullets').setup({
        symbols = {
          checkboxes = {
            todo = { " ", "OrgTODO" },
          },
        },
      })
    end,
  },
  {
    "vhyrro/luarocks.nvim",
    priority = 1000, -- We'd like this plugin to load first out of the rest
    config = true, -- This automatically runs `require("luarocks-nvim").setup()`
  },
  {
    "nvim-neorg/neorg",
    ft = { 'norg' },
    dependencies = { "luarocks.nvim" },
    -- put any other flags you wanted to pass to lazy here!
    config = function()
      require("neorg").setup({})
    end,
  }
}
