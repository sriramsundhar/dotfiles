local markdownlint_config = vim.fn.stdpath("config") .. "/lang-servers/markdownlint.jsonc"

return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, { "mermaid" })
    end,
  },
  {
    "mfussenegger/nvim-lint",
    optional = true,
    opts = function(_, opts)
      opts.linters = opts.linters or {}
      opts.linters["markdownlint-cli2"] = vim.tbl_deep_extend("force", opts.linters["markdownlint-cli2"] or {}, {
        args = { "--config", markdownlint_config, "-" },
      })
    end,
    keys = {
      {
        "<leader>uM",
        function()
          local ns = require("lint").get_namespace("markdownlint-cli2")
          Snacks.toggle({
            name = "Markdown Lint",
            get = function()
              return vim.diagnostic.is_enabled({ ns_id = ns })
            end,
            set = function(enabled)
              vim.diagnostic.enable(enabled, { ns_id = ns })
            end,
          }):toggle()
        end,
        ft = "markdown",
        desc = "Toggle Markdown Lint",
      },
    },
  },
  {
    "stevearc/conform.nvim",
    optional = true,
    opts = function(_, opts)
      opts.formatters = opts.formatters or {}
      opts.formatters["markdownlint-cli2"] = vim.tbl_deep_extend("force", opts.formatters["markdownlint-cli2"] or {}, {
        args = { "--fix", "$FILENAME", "--config", markdownlint_config },
      })
    end,
  },
}
