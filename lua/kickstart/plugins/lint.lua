-- External dependencies:
--   pipx install norminette    (c, cpp)

return {

  { -- Linting
    'mfussenegger/nvim-lint',
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
      local lint = require 'lint'

      --[[
      -- Define custom norminette linter
      lint.linters.norminette = {
        cmd = 'norminette',
        stdin = false,
        args = {},
        stream = 'stdout',
        ignore_exitcode = true,
        parser = function(output)
          local diagnostics = {}
          for line in output:gmatch '[^\r\n]+' do
            local error_name, lnum, col, msg = line:match '^Error:%s+(%S+)%s+%(line:%s*(%d+),%s*col:%s*(%d+)%):%s*(.*)'
            if error_name then
              table.insert(diagnostics, {
                lnum = tonumber(lnum) - 1,
                col = tonumber(col) - 1,
                severity = vim.diagnostic.severity.WARN,
                source = 'norminette',
                message = error_name .. ': ' .. msg,
              })
            end
          end
          return diagnostics
        end,
      }

      lint.linters_by_ft = {
        c = { 'norminette' },
        cpp = { 'norminette' },
      }
      ]]
      --

      -- Create autocommand which carries out the actual linting
      -- on the specified events.
      local lint_augroup = vim.api.nvim_create_augroup('lint', { clear = true })
      vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave' }, {
        group = lint_augroup,
        callback = function()
          -- Only run the linter in buffers that you can modify in order to
          -- avoid superfluous noise, notably within the handy LSP pop-ups that
          -- describe the hovered symbol using Markdown.
          if vim.bo.modifiable then
            lint.try_lint()
          end
        end,
      })
    end,
  },
}
