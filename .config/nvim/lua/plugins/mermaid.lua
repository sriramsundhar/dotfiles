return {
  "kevalin/mermaid.nvim",
  dependencies = { "nvim-treesitter/nvim-treesitter" },
  ft = { "mermaid" },
  config = function()
    -- PUPPETEER_EXECUTABLE_PATH is set in lua/config/options.lua, before any
    -- plugin (including this one) loads.
    require("mermaid").setup()

    -- Install the Tree-sitter parser:
    -- :TSInstall mermaid
  end,
}
