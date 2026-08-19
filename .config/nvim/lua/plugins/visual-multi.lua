return {
  "mg979/vim-visual-multi",
  init = function()
    -- Optional: Define your configuration options here before the plugin loads
    -- vim.g.VM_maps = { ['Find Under'] = '<C-n>' }
  end,
  -- Crucial: prevent lazy.nvim from lazy-loading this plugin
  lazy = false,
}
