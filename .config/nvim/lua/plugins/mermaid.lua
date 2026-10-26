local function render_markdown_mermaid_block()
  local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
  local cursor_row = vim.api.nvim_win_get_cursor(0)[1] -- 1-indexed

  local block_start, block_end
  local start = nil
  for i, line in ipairs(lines) do
    if not start then
      if line:match("^%s*```+%s*mermaid%s*$") then
        start = i
      end
    else
      if line:match("^%s*```+%s*$") then
        if cursor_row >= start and cursor_row <= i then
          block_start, block_end = start, i
          break
        end
        start = nil
      end
    end
  end

  if not block_start then
    vim.notify("Mermaid: cursor is not inside a ```mermaid code block", vim.log.levels.WARN)
    return
  end

  local content = table.concat(lines, "\n", block_start + 1, block_end - 1)
  local result = require("mermaid.render").render_source(content)
  if not result.ok then
    vim.notify("Mermaid: render failed: " .. (result.error or "unknown"), vim.log.levels.ERROR)
  else
    vim.notify("Mermaid: rendered inline via " .. result.method, vim.log.levels.INFO)
  end
end

return {
  "kevalin/mermaid.nvim",
  dependencies = { "nvim-treesitter/nvim-treesitter" },
  config = function()
    require("mermaid").setup()

    -- Install the Tree-sitter parser:
    -- :TSInstall mermaid
  end,
  keys = {
    {
      "<leader>mr",
      render_markdown_mermaid_block,
      ft = "markdown",
      desc = "Render Mermaid Block Inline",
    },
  },
}
