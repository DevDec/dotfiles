local wezterm = require 'wezterm'
local act = wezterm.action

local M = {}

local function escapePattern(str)
    local specialCharacters = "([%.%+%-%%%[%]%*%?%^%$%(%)])"
    return (str:gsub(specialCharacters, "%%%1"))
end

local run_command = function(command)
	local handle = io.popen(command .. "\n")

	if handle == nil then
		return false
	end

	local result = handle:read("*a")

	handle:close()
	return result
end

local function get_bare_repo_root(working_dir)
	local worktree_dir = run_command("git -C " .. working_dir .. " rev-parse --absolute-git-dir")
	if not worktree_dir or worktree_dir == "" then
		return false
	end

	local is_worktree_dir  = io.open(working_dir .. "/.git" ,"r")

	-- All worktree directories have a .git file rarther than a .git directory, if the file does not exist then it is not a worktree directory
	if not is_worktree_dir then
		return false
	end

	-- Remove everything after "/worktrees/"
	local bare_repo_root = worktree_dir:match("^(.*)/worktrees/") or worktree_dir

	-- Trim whitespace again
	bare_repo_root = bare_repo_root:match("^%s*(.-)%s*$") or ""

	-- Log final bare_repo_root
	wezterm.log_info("Bare repo root 2: " .. bare_repo_root)

	return string.gsub(bare_repo_root, "//", '')
end

local function get_worktrees(working_dir)
	wezterm.log_info("Working dir: " .. working_dir)

	local result = run_command("git -C " .. working_dir .. " worktree list")

    -- Table to store parsed worktrees
    local worktrees = {}

    -- Parse each line of the output
    for line in result:gmatch("[^\r\n]+") do
        local path, head, _ = line:match("([%S]+)%s*([%S]+)%s*(.*)")
        if path and head then
            table.insert(worktrees, {
            	label = path,
				id = path
            })
        end
    end
	return worktrees
end

local function get_remote_branches(working_dir)
	local remote_branches = {}
	local result = run_command("git -C " .. working_dir .. " branch -r")

    for branch in result:gmatch("[^\r\n]+") do
        if branch then
            table.insert(remote_branches, {
            	label = branch,
				id = branch
            })
        end
    end

	return remote_branches
end

local function kill_curent_process(pane)
	local process_name = pane:get_foreground_process_name()

	if not string.find(process_name,  "zsh") then
		-- Kill the current process, usually antother nvim process
		local process_id = pane:get_foreground_process_info().pid
		os.execute("kill -9 " .. process_id)
	end
end

local function create_worktree(branch_name, remote_branch, working_dir, window, pane)
	local is_new = remote_branch ~= nil

	local bare_repo_root = get_bare_repo_root(working_dir)

	if not bare_repo_root then
		wezterm.log_error("Could not get the bare repo root")
		return
	end

	branch_name = branch_name:match("^%s*(.-)%s*$") or ""

	if remote_branch then
		remote_branch = remote_branch:match("^%s*(.-)%s*$") or ""
	else
		local remotes = run_command("git -C " .. bare_repo_root .. " remote show")

		if not remotes then
			window:toast_notification('Worktree creation error', 'No remotes found, please create worktree from existing branch instead', nil, 4000)
			return
		end

		for remote in remotes:gmatch("[^\r\n]+") do
			if string.find(branch_name, remote) then
				remote_branch = branch_name
				branch_name = string.gsub(branch_name, remote .. "/", "")
				break
			end
		end
	end

	wezterm.log_info("Creating worktree for branch: " .. branch_name .. " from remote branch: " .. remote_branch)

	local worktree_exists = run_command("git -C " .. bare_repo_root .. " worktree list | grep '" .. bare_repo_root .. "/" .. branch_name .. "'")

	if worktree_exists and worktree_exists ~= "" then
		window:toast_notification('Worktree creation error', 'Worktree already exists, please switch to it instead', nil, 4000)
		return
	end

	local branch_exists = run_command("git -C " .. bare_repo_root .. " branch --list -l " .. branch_name)

	if branch_exists and is_new and branch_exists ~= "" then
		window:toast_notification('Worktree creation error', 'Branch provided already exists, please create worktree from existing branch instead', nil, 4000)
		return
	elseif not branch_exists or branch_exists == "" then
		run_command("git -C " .. bare_repo_root .. " branch " .. branch_name .. " " .. remote_branch)
	end

	wezterm.log_info("killing current process")

	wezterm.log_info("process killed")

	kill_curent_process(pane)

	local command = "git -C " .. bare_repo_root .. " worktree add " .. branch_name .. " " .. branch_name
	window:perform_action(wezterm.action { SendString = command .. "\n" }, pane)

	wezterm.log_info("Worktree created" .. command)

	if string.find(working_dir, "storeVisionPep") then
		window:perform_action(wezterm.action { SendString = "cd " .. bare_repo_root .. "/" .. branch_name .. "; visionComposer;  nvim\n" }, pane)
		return
	end

	wezterm.log_info("cd " .. bare_repo_root .. "/" .. branch_name .. "\n")
	window:perform_action(wezterm.action { SendString = "cd " .. bare_repo_root .. "/" .. branch_name .. " ; nvim\n" }, pane)
end

local function create_worktree_input(working_dir, window, pane, remote_branch)
	window:perform_action(
	act.PromptInputLine {
		description = 'Enter a new branch/worktree name',
		action = wezterm.action_callback(function(window, pane, line)
			if not line or line == "" then
				return
			end

			create_worktree(line, remote_branch, working_dir, window, pane)
		end),
	},
	pane)
end

local function create_worktree_from_new(working_dir, remote_branches, window, pane)
	window:perform_action(
	act.InputSelector {
		action = wezterm.action_callback(
		function(window, pane, id, label)
			if not id or id == "" then
				return
			end

			create_worktree_input(working_dir, window, pane, id)
		end
		),
		description = 'Select a remote branch to track',
		choices = remote_branches
	},
	pane
	)
end

local function create_worktree_from_existing(working_dir, remote_branches, window, pane)
	window:perform_action(
		act.InputSelector {
			action = wezterm.action_callback(
				function(window, pane, id, label)
					if not id or id == "" then
						return
					end

					create_worktree(id, nil, working_dir, window, pane)
				end
			),
			description = 'Select a branch to create a worktree from',
			choices = remote_branches
		},
	pane)
end

M.switch_worktree_binding = function()
	return {
		key = 'e',
		mods = 'LEADER',
		action = wezterm.action_callback(function(window, pane)
			local working_dir = pane:get_current_working_dir().file_path
			local worktrees = get_worktrees(working_dir)

			window:perform_action(
			act.InputSelector {
				action = wezterm.action_callback(function(window, pane, id, _)
					if not id or id == "" then
						return
					end

					kill_curent_process(pane)

					window:perform_action(wezterm.action { SendString = "cd " .. id .. ";  nvim\n" }, pane)
				end),
				description = 'Select a worktree',
				choices = worktrees
			}, pane)
		end
		)
	}
end

M.create_worktree_binding = function()
	return {
		key = 'A',
		mods = 'ALT|SHIFT',
		action = wezterm.action_callback(function(window, pane)
			local working_dir = pane:get_current_working_dir().file_path
			local remote_branches = get_remote_branches(working_dir)

			local bare_repo_root = get_bare_repo_root(working_dir)

			if not bare_repo_root then
				wezterm.log_error("Could not get the bare repo root")
				window:toast_notification('Worktree creation error', 'Unable to create worktree, either not a worktree directory OR cant locate the bare repo root', nil, 4000)
				return
			end

			window:perform_action(act.InputSelector {
				action = wezterm.action_callback(
					function(window, pane, id, label)
						if not id or id == "" then
							return
						end

						if id == "new" then
							create_worktree_from_new(working_dir, remote_branches, window, pane)
							return
						else
							create_worktree_from_existing(working_dir, remote_branches, window, pane)
						end
					end
				),
				description = 'Select a remote branch to track',
				choices = {
					{
						id = "new",
						label = "Create from new branch"
					},
					{
						id = "existing",
						label = "Create from existing branch"
					}
				}
			}, pane)
		end
		)
	}
end

return M

