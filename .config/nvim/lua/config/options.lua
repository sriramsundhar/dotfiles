-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
vim.g.autoformat = false

-- mmdc (mermaid-cli, used by mermaid.nvim and Snacks.image to render ```mermaid
-- blocks) shells out to puppeteer, which needs a real Chrome/Chromium; nixpkgs'
-- mermaid-cli doesn't bundle one, so point it at the system install. Set before
-- lazy.nvim loads any plugin so every mmdc invocation inherits it.
if vim.env.PUPPETEER_EXECUTABLE_PATH == nil then
  local chrome = "/Applications/Google Chrome.app/Contents/MacOS/Google Chrome"
  if vim.fn.filereadable(chrome) == 1 then
    vim.env.PUPPETEER_EXECUTABLE_PATH = chrome
  end
end
