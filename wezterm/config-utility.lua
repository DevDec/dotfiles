local utility = {}
local wezterm = require 'wezterm'
local mux = wezterm.mux
local act = wezterm.action

utility.setTabSwitch = function(config)
	for i = 1, 8 do
		-- CTRL+ALT + number to activate that tab
		table.insert(config.keys, {
			key = tostring(i),
			mods = 'LEADER',
			action = act.ActivateTab(i - 1),
		})
	end
end

utility.setWindowConfig = function(config)
	config.enable_tab_bar = true
	config.enable_scroll_bar = false
	config.window_padding = {
		left = 0,
		right = 0,
		top = 0,
		bottom = 0
	}
	config.font_size = 10
	config.line_height = 2
	config.window_decorations = "RESIZE"
	-- config.color_scheme = "Dracula"
	config.warn_about_missing_glyphs = false
	config.use_resize_increments = true
	config.font = wezterm.font("JetBrains Mono Nerd Font")

	-- config.background = {
	-- 	{
	-- 		source = {
	-- 			File = "/home/declanb/Pictures/Wallpapers/nordic-wallpaper.jpg",
	-- 		},
	-- 		hsb = dimmer,
	-- 	},
	-- }

	config.window_frame = {
		-- The font used in the tab bar.
		-- Roboto Bold is the default; this font is bundled
		-- with wezterm.
		-- Whatever font is selected here, it will have the
		-- main font setting appended to it to pick up any
		-- fallback fonts you may have used there.
		font = wezterm.font("JetBrains Mono Nerd Font"),

		-- The size of the font in the tab bar.
		-- Default to 10.0 on Windows but 12.0 on other systems
		font_size = 10.2,

		-- The overall background color of the tab bar when
		-- the window is focused
		active_titlebar_bg = '#1f1f28',


		-- The overall background color of the tab bar when
		-- the window is not focused
		inactive_titlebar_bg = '#1f1f28',
	}

	config.force_reverse_video_cursor = true
	config.use_fancy_tab_bar = true
	config.show_new_tab_button_in_tab_bar = false
	-- Only in nightly builds of wezterm
	-- config.show_close_tab_button_in_tabs = false

	config.colors = {
		tab_bar = {
			active_tab = {
				bg_color = '#1f1f28',
				fg_color = '#dcd7ba'
			}
		},
		foreground = "#dcd7ba",
		background = "#1f1f28",

		cursor_bg = "#c8c093",
		cursor_fg = "#c8c093",
		cursor_border = "#c8c093",

		selection_fg = "#c8c093",
		selection_bg = "#2d4f67",

		scrollbar_thumb = "#16161d",
		split = "#16161d",

		ansi = { "#090618", "#c34043", "#76946a", "#c0a36e", "#7e9cd8", "#957fb8", "#6a9589", "#c8c093" },
		brights = { "#727169", "#e82424", "#98bb6c", "#e6c384", "#7fb4ca", "#938aa9", "#7aa89f", "#dcd7ba" },
		indexed = { [16] = "#ffa066", [17] = "#ff5d62" },
	}
end

utility.createAimWorkspaces = function()
	local editorTab, build_pane, storeVisionPepWindow = mux.spawn_window {
		workspace = 'storeVisionPep',
		cwd = '/home/declanb/Documents/Projects/storeVisionPep',
	}
	storeVisionPepWindow:gui_window():maximize()
	editorTab:set_title("Shell")


	local shellTab = storeVisionPepWindow:spawn_tab {
		workspace = 'storeVisionPep',
		cwd = '/home/declanb/Documents/Projects/storeVisionPep',
	}

	shellTab:set_title("Edit")

	local devTab, pane, sqlWindow = mux.spawn_window {
		workspace = 'sql',
		cwd = '/home/declanb/scripts/sql/',
	}

	devTab:set_title("dev")

	local homeTab, pane, homeWindow = mux.spawn_window {
		workspace = 'home',
		cwd = '/home/declanb',
	}

	homeTab:set_title("home")


	-- We want to startup in the coding workspace
	mux.set_active_workspace 'storeVisionPep'
end

utility.createStandardWorkspaces = function()
	local editorTab, build_pane, window = mux.spawn_window {
		workspace = 'Standard',
		cwd = '/home/declanb',
	}

	window:gui_window():maximize()
	editorTab:set_title("Edit")

	mux.set_active_workspace 'Standard'
end


return utility
