local wezterm = require 'wezterm';
local statusBarConfig = {}
statusBarConfig.updateRightStatus = function(window, pane)
  	local cwd = " "..pane:get_current_working_dir().file_path:sub(7).." ";
	local hostname = " "..wezterm.hostname().." ";

	window:set_right_status(
		wezterm.format({
			{Foreground={Color="#ffffff"}},
			{Background={Color="#1f1f28"}},
			{Text=cwd},
		})..
		wezterm.format({
			{Foreground={Color="#ffffff"}},
			{Background={Color="#1f1f28"}},
			{Text="|"},
		})..
		wezterm.format({
			{Foreground={Color="#ffffff"}},
			{Background={Color="#1f1f28"}},
			{Text=hostname},
		})
	);
end

return statusBarConfig
