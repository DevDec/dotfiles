local transmit = require('transmit')
transmit.setup({
	config_location = "/home/declanb/transmit_sftp/config.json",
	upload_on_bufwrite = false,
	watch_for_changes = true
})

-- tree_api.events.subscribe(Event.FolderRemoved, remove_folder)
-- tree_api.events.subscribe(Event.FileRemoved, remove_file)
--
-- vim.api.nvim_create_augroup("transmit_custom_augroup", { clear = true })
-- vim.api.nvim_create_cmd("User", {
-- 	group = "transmit_custom_augroup",
-- 	pattern = "TransmitUploadGitModifiedFiles",
-- 	callback = upload_git_modified_files,
-- })
--
vim.api.nvim_create_user_command('TransmitUploadGitModifiedFiles',
function()
	local transmit = require('transmit')
	local working_dir = vim.loop.cwd()
	local changed_files = {}

	vim.fn.jobstart(
	{
		'git',
		'diff',
		'--name-only'
	},
	{
		on_stdout = function(_, data, _)
			for k,value in pairs(data) do
				if value == nil or value == '' then
					goto continue
				end

				table.insert(changed_files, value)
				::continue::
			end
		end
	})

	vim.fn.jobstart(
	{
		'git',
		'diff',
		'--cached',
		'--name-only'
	},
	{
		on_stdout = function(_, data, _)
			for k,value in pairs(data) do
				if value == nil or value == '' then
					goto continue
				end

				table.insert(changed_files, value)
				::continue::
			end
		end,
		on_exit = function(_, code, _)
			if changed_files == nil or next(changed_files) == nil then
				return false
			end

			for k, file in pairs(changed_files) do
				file = working_dir .. '/' .. file

				local f = io.open(file, "r")
				local file_exists = false
				if f ~= nil then
					file_exists = true
					io.close(f)
				end

				if file_exists == false then
					transmit.remove_path(file)
				else
					transmit.upload_file(file)
				end

			end
		end
	})
end
, {})
