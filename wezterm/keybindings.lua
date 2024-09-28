local wezterm = require 'wezterm'
local worktrees = require 'worktrees'

local act = wezterm.action

return {
	worktrees.switch_worktree_binding(),
	worktrees.create_worktree_binding(),
	{
		key = 'w',
		mods = 'LEADER',
		action = act.ShowLauncherArgs {
			flags = 'FUZZY|WORKSPACES',
		},
	},
	{
		key = 'd',
		mods = 'LEADER',
		action = wezterm.action.CloseCurrentPane { confirm = true },
	},
	{
		key = 'c',
		mods = 'LEADER',
		action = act.PromptInputLine {
			description = wezterm.format {
				{ Attribute = { Intensity = 'Bold' } },
				{ Foreground = { AnsiColor = 'Fuchsia' } },
				{ Text = 'Enter name for new workspace' },
			},
			action = wezterm.action_callback(function(window, pane, line)
				-- line will be `nil` if they hit escape without entering anything
				-- An empty string if they just hit enter
				-- Or the actual line of text they wrote
				if line then
					window:perform_action(
					act.SwitchToWorkspace {
						name = line,
					},
					pane
					)
				end
			end),
		},
	},
	{ key = 't', mods = 'LEADER', action = wezterm.action.ShowTabNavigator },
	{
		key = 'r',
		mods = 'LEADER',
		action = wezterm.action.ReloadConfiguration,
	},
	-- This will create a new split and run the `top` program inside it
	{
		key = 'v',
		mods = 'LEADER',
		action = wezterm.action.SplitVertical {
			args = { },
		},
	},
	-- This will create a new split and run the `top` program inside it
	{
		key = 'h',
		mods = 'LEADER',
		action = wezterm.action.SplitHorizontal {
			args = { },
		},
	},
	{ key = 'q', mods = 'LEADER', action = wezterm.action.QuitApplication },
	{
		key = 'h',
		mods = 'CTRL|SHIFT',
		action = act.ActivatePaneDirection 'Left',
	},
	{
		key = 'l',
		mods = 'CTRL|SHIFT',
		action = act.ActivatePaneDirection 'Right',
	},
	{
		key = 'k',
		mods = 'CTRL|SHIFT',
		action = act.ActivatePaneDirection 'Up',
	},
	{
		key = 'DownArrow',
		mods = 'CTRL|SHIFT',
		action = act.ActivatePaneDirection 'Down',
	},
	-- CTRL-SHIFT-l activates the debug overlay
	{ key = 'l', mods = 'LEADER', action = wezterm.action.ShowDebugOverlay },
}
