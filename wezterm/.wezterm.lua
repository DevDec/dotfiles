local wezterm = require 'wezterm'
local keyBindings = require 'keybindings'
local configUtility = require 'config-utility'
local statusBarConfig = require 'status-bar'

wezterm.on("gui-startup", function()
	local startupEnv = os.getenv("WEZTERM_STARTUP")

	if startupEnv == "Aim Smarter" then
		configUtility.createAimWorkspaces()
	elseif startupEnv == "Standard" or startupEnv == nil or startupEnv == "" then
		configUtility.createStandardWorkspaces()
	end
end)

local config = {}

if wezterm.config_builder then
  config = wezterm.config_builder()
end

configUtility.setWindowConfig(config)
configUtility.setupSshDomains(config)
config.leader = { key = 'a', mods = 'ALT', timeout_milliseconds = 2000  }
config.keys = keyBindings
config.front_end = "WebGpu"
config.webgpu_power_preference = "HighPerformance"
configUtility.setTabSwitch(config)
wezterm.on("update-right-status", statusBarConfig.updateRightStatus)

return config
