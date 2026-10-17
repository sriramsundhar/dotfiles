return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        marksman = {},
      },
    },
  },
  {
    "mfussenegger/nvim-jdtls",
    opts = function(_, opts)
      local fname = vim.api.nvim_buf_get_name(0)
      local root_dir = (opts.root_dir and opts.root_dir(fname)) or vim.fn.getcwd()
      local local_formatter = root_dir .. "/checkstyle/checkstyle.xml"
      local formatter_url = vim.fn.filereadable(local_formatter) == 1 and local_formatter
        or (vim.fn.stdpath("config") .. "/lang-servers/eclipse-formatter.xml")

      opts.settings = opts.settings or {}
      opts.settings.java = vim.tbl_deep_extend("force", opts.settings.java or {}, {
        format = {
          settings = {
            url = formatter_url,
            profile = "CustomLineLength",
          },
        },
        completion = {
          -- single empty-prefix group puts every import in one alphabetically sorted block
          importOrder = { "#", "" },
        },
      })
    end,
  },
}
