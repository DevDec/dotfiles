local Terminal = require("toggleterm.terminal").Terminal

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
