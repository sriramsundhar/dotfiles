return {
  {
    "3rd/image.nvim",
    build = false, -- use magick CLI instead of the Lua rock, no compile step needed
    opts = {
      backend = "kitty",
      processor = "magick_cli",
    },
  },
  {
    "3rd/diagram.nvim",
    dependencies = { "3rd/image.nvim" },
    ft = { "markdown" },
    opts = {
      renderer_options = {
        mermaid = {
          theme = vim.o.background == "dark" and "dark" or "default",
          background = "transparent",
        },
      },
    },
  },
}
