local action_state = require "telescope.actions.state";
local utils = require "telescope.utils"

local git = {}

--- Ask user to confirm an action
---@param prompt string: The prompt for confirmation
---@param default_value string: The default value of user input
---@param yes_values table: List of positive user confirmations ({"y", "yes"} by default)
---@return boolean: Whether user confirmed the prompt
local function ask_to_confirm(prompt, default_value, yes_values)
  yes_values = yes_values or { "y", "yes" }
  default_value = default_value or ""
  local confirmation = vim.fn.input(prompt, default_value)
  confirmation = string.lower(confirmation)
  if string.len(confirmation) == 0 then
    return false
  end
  for _, v in pairs(yes_values) do
    if v == confirmation then
      return true
    end
  end
  return false
end

function git.drop_stash(prompt_bufnr)
  local selection = action_state.get_selected_entry()

  local confirmation = ask_to_confirm(string.format("Drop stash '%s'? [y/n]: ", selection.value))
  if not confirmation then
    utils.notify("actions.git_drop_stash", {
        msg = string.format("Drop stash canceled: '%s'", selection.value),
        level = "INFO",
      })
    return
  end

  local picker = action_state.get_current_picker(prompt_bufnr)
  picker:delete_selection(function(selection)
    local _, ret, stderr = utils.get_os_command_output { "git", "stash", "drop", selection.value }

    if ret == 0 then
      utils.notify("actions.git_drop_stash", {
          msg = string.format("Dropped stash: '%s' ", selection.value),
          level = "INFO",
        })
    else
      utils.notify("actions.git_apply_stash", {
          msg = string.format("Error when dropping: %s. Git returned: '%s'", selection.value, table.concat(stderr, " ")),
          level = "ERROR",
        })
    end

    return ret == 0
  end)
end

return {
  git
}
