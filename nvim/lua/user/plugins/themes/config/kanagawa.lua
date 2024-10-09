vim.cmd("colorscheme kanagawa")
-- Set the background color of the line numbers
vim.cmd('highlight LineNr guibg=#1f1f28')

-- Set the background color of the sign column (gutter)
vim.cmd('highlight SignColumn guibg=#1f1f28')

vim.fn.sign_define('DiagnosticSignError', { text = '', texthl = 'DiagnosticSignError'})
vim.fn.sign_define('DiagnosticSignWarn', { text = '', texthl = 'DiagnosticSignWarn'})
vim.fn.sign_define('DiagnosticSignInfo', { text = '', texthl = 'DiagnosticSignInfo'})
vim.fn.sign_define('DiagnosticSignHint', { text = '', texthl = 'DiagnosticSignHint'})

local function setHighlightGroupBackgroundColour(group, colour)
	local hl_groups = vim.fn.getcompletion('', 'highlight')

	for _, foundGroup in ipairs(hl_groups) do
		if (foundGroup:sub(1, #group) == group) then
			local hl = vim.api.nvim_get_hl_by_name(foundGroup, true)
			vim.api.nvim_set_hl(0, foundGroup, {
				fg = hl.foreground,
				bg = colour,
			})
		end
	end
end

-- setHighlightGroupBackgroundColour("GitSigns", "#1f1f28")
setHighlightGroupBackgroundColour("GitSigns", "none")
setHighlightGroupBackgroundColour("MiniDiff", "none")
setHighlightGroupBackgroundColour("Telescope", "none")
setHighlightGroupBackgroundColour("Treesitter", "none")
-- setHighlightGroupBackgroundColour("DiagnosticSign", "#1f1f28")
setHighlightGroupBackgroundColour("DiagnosticSign", "none")

-- vim.cmd [[
--   highlight Normal guibg=none
--   highlight NonText guibg=none
--   highlight Normal ctermbg=none
--   highlight NonText ctermbg=none
-- ]]
