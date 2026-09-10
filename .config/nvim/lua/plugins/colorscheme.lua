return {
  "folke/tokyonight.nvim",
  lazy = false,
  priority = 1000,
  opts = {
    transparent = false,
    styles = {
      sidebars = "transparent",
      floats = "transparent",
    },
  },
  config = function(_, opts)
    require("tokyonight").setup(opts)
    vim.cmd.colorscheme("tokyonight")

    -- Track transparency state
    local transparent = opts.transparent

    -- Keybinding to toggle transparency
    vim.keymap.set("n", "<leader>tt", function()
      transparent = not transparent
      require("tokyonight").setup({
        transparent = transparent,
        styles = {
          sidebars = "transparent",
          floats = "transparent",
        },
      })
      vim.cmd.colorscheme("tokyonight")
    end, { desc = "Toggle transparency" })
  end,
}
