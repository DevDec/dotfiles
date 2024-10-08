local separator = { '"▏"', color = 'StatusLineNonText' }

local function escapePattern(str)
    local specialCharacters = "([%.%+%-%%%[%]%*%?%^%$%(%)])"
    return (str:gsub(specialCharacters, "%%%1"))
end


local function get_file_path()
	local working_dir = vim.loop.cwd() .. "/"
	local buf = vim.api.nvim_buf_get_name(0)

	return string.gsub(buf, "^" .. vim.pesc(working_dir), "")
	-- return string.gsub(buf, working_dir, "")
end

local function get_current_server()
	local transmit = require('transmit')

	local server = transmit.get_current_server()
	local remote = transmit.get_current_remote()

	if server == "none" then
		return " " .. server
	end

	return  " " .. server .. " > " .. remote
end

require('lualine').setup({
  options = {
    section_separators = '',
    component_separators = '',
    globalstatus = true,
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
	-- 'filename',
	get_file_path,
	get_current_server,
	require("recorder").displaySlots,
	require("recorder").recordingStatus
	  -- function()
	  --  -- vim.print(require('lsp-progress').progress())
	  --  return require('lsp-progress').progress()
	  -- end,
    },
    -- lualine_d = {
    --   -- 'Transmit Server: ' .. require('transmit').get_current_server()
    -- },
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
