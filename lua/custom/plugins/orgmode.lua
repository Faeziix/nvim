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
}
