local separator = { '"▏"', color = 'StatusLineNonText' }

require('lualine').setup({
  options = {
    section_separators = '',
    component_separators = '',
    globalstatus = true,
	-- theme = require('user/plugins/ui/config/lualinetheme').theme(),
    theme = {
      normal = {
        a = 'StatusLine',
        b = 'StatusLine',
        c = 'StatusLine',
      },
    },
  },
  sections = {
    lualine_a = {
      'mode',
    },
    lualine_b = {
      'branch',
      'diff',
      -- '"🖧  " .. tostring(#vim.tbl_keys(vim.lsp.buf_get_clients()))',
      -- { 'diagnostics', sources = { 'nvim_diagnostic' } },
      -- separator,
    },
    lualine_c = {
	'filename'
	  -- function()
	  --  -- vim.print(require('lsp-progress').progress())
	  --  return require('lsp-progress').progress()
	  -- end,
    },
    lualine_d = {
      -- 'Transmit Server: ' .. require('transmit').get_current_server()
    },
    lualine_x = {
      'filetype',
      'encoding',
      'fileformat',
    },
    lualine_y = {
      '(vim.bo.expandtab and "␠ " or "⇥ ") .. " " .. vim.bo.shiftwidth',
    },
    lualine_z = {
      'location',
      'progress',
    },
  },
})

-- -- listen lsp-progress event and refresh lualine
-- vim.api.nvim_create_augroup("lualine_augroup", { clear = true })
-- vim.api.nvim_create_autocmd("User", {
--   group = "lualine_augroup",
--   pattern = "LspProgressStatusUpdated",
--   callback = function() 
-- 	  require("lualine").refresh
--   end,
-- })
