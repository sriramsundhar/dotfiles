return {
  "akinsho/toggleterm.nvim",
  version = "*",
  config = function()
    require("toggleterm").setup({
      -- Set the default layout to floating
      direction = "float",
      -- Set the toggle shortcut (e.g., Ctrl + \)
      open_mapping = [[<c-\>]],
      -- Customize the floating window appearance
      float_opts = {
        border = "curved", -- Options: 'single', 'double', 'shadow', 'curved'
        winblend = 3, -- Sets transparency
      },
    })
  end,
}
