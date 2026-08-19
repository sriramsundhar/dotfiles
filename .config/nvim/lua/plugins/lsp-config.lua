return {
  {
    "mason-org/mason.nvim",
    opts = {
      ui = {
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗"
        }
      }
    }
  },
  {
    "mason-org/mason-lspconfig.nvim",
    dependencies = {
      "mason-org/mason.nvim",
      "neovim/nvim-lspconfig",
    },
    opts = {
      ensure_installed = {
        "lua_ls",
        "ts_ls",
        "bashls",
        "jdtls",
        "dockerls",
        "rnix",
        "pylsp"
      },
      automatic_installation = true,
    },
  },
  {
    "neovim/nvim-lspconfig",
    lazy = false,
    dependencies = {
      "mason-org/mason.nvim",
      "mason-org/mason-lspconfig.nvim",
    },
    config = function()
      -- Setup keybindings when LSP attaches
      vim.api.nvim_create_autocmd('LspAttach', {
        callback = function(args)
          local opts = { buffer = args.buf, noremap = true, silent = true }
          vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
          vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, opts)
          vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, opts)
          vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
          vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
          vim.keymap.set('n', '<leader>f', function()
            vim.lsp.buf.format({ async = true })
          end, opts)
        end,
      })

      -- Default capabilities for all LSP servers
      local capabilities = vim.lsp.protocol.make_client_capabilities()

      -- Helper function to find project root
      local function find_root(patterns)
        return function()
          local found = vim.fs.find(patterns, { upward = true })[1]
          return found and vim.fs.dirname(found) or vim.fn.getcwd()
        end
      end

      -- LSP server configurations
      local servers = {
        lua_ls = {
          cmd = { 'lua-language-server' },
          filetypes = { 'lua' },
          root_patterns = { '.git', '.luarc.json', '.luarc.jsonc' },
        },
        jdtls = {
          cmd = { vim.fn.stdpath('data') .. '/mason/bin/jdtls' },
          filetypes = { 'java' },
          root_patterns = { '.git', 'pom.xml', 'build.gradle', 'gradlew', 'mvnw' },
          settings = {
            java = {
              home = os.getenv('JAVA_HOME'),
              configuration = { runtimes = {} }
            }
          },
        },
        ts_ls = {
          cmd = { 'typescript-language-server', '--stdio' },
          filetypes = { 'javascript', 'javascriptreact', 'typescript', 'typescriptreact' },
          root_patterns = { '.git', 'package.json', 'tsconfig.json' },
        },
        bashls = {
          cmd = { 'bash-language-server', 'start' },
          filetypes = { 'sh', 'bash' },
          root_patterns = { '.git' },
        },
        dockerls = {
          cmd = { 'docker-langserver', '--stdio' },
          filetypes = { 'dockerfile' },
          root_patterns = { '.git' },
        },
        pylsp = {
          cmd = { 'pylsp' },
          filetypes = { 'python' },
          root_patterns = { '.git', 'setup.py', 'pyproject.toml' },
        },
        rnix = {
          cmd = { 'rnix-lsp' },
          filetypes = { 'nix' },
          root_patterns = { '.git', 'flake.nix' },
        },
      }

      -- Create FileType autocommands for each server
      for name, config in pairs(servers) do
        vim.api.nvim_create_autocmd('FileType', {
          pattern = config.filetypes,
          callback = function()
            vim.lsp.start({
              name = name,
              cmd = config.cmd,
              root_dir = find_root(config.root_patterns)(),
              settings = config.settings or {},
              capabilities = capabilities,
            })
          end,
        })
      end
    end,
  },
}
