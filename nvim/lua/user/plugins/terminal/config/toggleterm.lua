local Terminal = require("toggleterm.terminal").Terminal

require("toggleterm").setup({
  size = function(term)
    -- Full screen width and height
    return vim.o.columns, vim.o.lines
  end,
  direction = "float",
  open_mapping = [[<c-t>]], -- your preferred mapping
  float_opts = {
	  border = "curved", -- No border for full screen effect
	  width = function()
		  return vim.o.columns
	  end,
	  height = function()
		  return vim.o.lines
	  end,
  },
})

local gitui = Terminal:new({
  cmd = "gitui",
  dir = "git_dir",
  direction = "float",
  float_opts = {
    border = "double",
  },
  -- function to run on opening the terminal
  on_open = function(term)
    -- vim.cmd("startinsert!")
    vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", {noremap = true, silent = true})
  end
})

function gituiToggle()
	-- vim.print("Toggling gitui")
  gitui:toggle()
end

vim.api.nvim_set_keymap("n", "<leader>l", "<cmd>lua gituiToggle()<CR>", {noremap = true, silent = true})
