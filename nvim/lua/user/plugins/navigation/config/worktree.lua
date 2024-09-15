local Worktree = require('git-worktree')

Worktree.setup({
	clearjumps_on_change = true
})

function file_exists(filename)
    local file = io.open(filename, "r") -- Try to open the file in read mode
    if file then
        io.close(file) -- Close the file if it exists
        return true
    else
        return false
    end
end

Worktree.on_tree_change(function(op, metadata)
	local transmit = require('transmit')
	if op == Worktree.Operations.Create then
		local directory = vim.loop.cwd()

		if (string.find(directory, 'storeVisionPep')) then
			local newDirectory = '/home/declanb/Documents/Projects/storeVisionPep/' .. metadata.path

			if file_exists(newDirectory .. '/.php-cs-fixere.diste.php') then
				os.execute('rm ' .. newDirectory .. '/.php-cs-fixer.dist.php')
			else
				-- vim.print('File does not exist')
			end

			if file_exists(newDirectory .. '/.php-cs-fixer.dist.php') then
				os.execute('rm ' .. newDirectory .. '/.php-cs-fixer.dist.php')
			else
				-- vim.print('File does not exist')
			end

			if file_exists(newDirectory .. '/.php_cs.dist') then
				os.execute('rm ' .. newDirectory .. '/.php_cs.dist')
			else
				-- vim.print('File does not exist')
			end

			if file_exists(newDirectory .. '/.php-cs-fixer.cache') then
				os.execute('rm ' .. newDirectory .. '/.php-cs-fixer.cache')
			else
				-- vim.print('File does not exist')
			end

			if file_exists(newDirectory .. '/.php_cs.cache') then
				os.execute('rm ' .. newDirectory .. '/.php_cs.cache')
			else
				-- vim.print('File does not exist')
			end

			if file_exists(newDirectory .. '/.phpactor.json') then
				os.execute('rm ' .. newDirectory .. '/.phpactor.json')
			else
				-- vim.print('File does not exist')
			end

			if file_exists(newDirectory .. '/psalm.xml') then
				-- print("File exists")
			else
				os.execute('cp -r /home/declanb/Documents/php74-container/psalm.xml ' .. newDirectory .. '/psalm.xml')
			end

			if file_exists(newDirectory .. '/.phpcs.xml') then
				-- print("File exists")
			else
				os.execute('cp -r /home/declanb/Documents/php74-container/.phpcs.xml ' .. newDirectory .. '/.phpcs.xml')
			end

			os.execute('cp -r /home/declanb/Documents/php74-container/phpactor.json ' .. newDirectory .. '/.phpactor.json')

			transmit.remove_watch()

			vim.cmd('clearjumps')
			vim.cmd('!visionComposer ' .. newDirectory)
			vim.cmd('LspRestart')
			vim.print('Restarting LSP servers...')
			vim.cmd('NvimTreeRefresh')
		end
	elseif op == Worktree.Operations.Switch then
		local directory = vim.loop.cwd()

		if (string.find(directory, 'storeVisionPep')) then
			if file_exists(metadata.path .. '/.php-cs-fixere.diste.php') then
				os.execute('rm ' .. metadata.path .. '/.php-cs-fixer.dist.php')
			else
				-- vim.print('File does not exist')
			end

			if file_exists(metadata.path .. '/.php-cs-fixer.dist.php') then
				os.execute('rm ' .. metadata.path .. '/.php-cs-fixer.dist.php')
			else
				-- vim.print('File does not exist')
			end

			if file_exists(metadata.path .. '/.php_cs.cache') then
				os.execute('rm ' .. metadata.path .. '/.php_cs.cache')
			else
				-- vim.print('File does not exist')
			end

			if file_exists(metadata.path .. '/.php_cs.dist') then
				os.execute('rm ' .. metadata.path .. '/.php_cs.dist')
			else
				-- vim.print('File does not exist')
			end

			if file_exists(metadata.path .. '/.php-cs-fixer.cache') then
				os.execute('rm ' .. metadata.path .. '/.php-cs-fixer.cache')
			else
				-- vim.print('File does not exist')
			end

			if file_exists(metadata.path .. '/.phpactor.json') then
				os.execute('rm ' .. metadata.path .. '/.phpactor.json')
			else
				-- vim.print('File does not exist')
			end

			if file_exists(metadata.path .. '/psalm.xml') then
				-- print("File exists")
			else
				os.execute('cp -r /home/declanb/Documents/php74-container/psalm.xml ' .. metadata.path .. '/psalm.xml')
			end

			if file_exists(metadata.path .. '/.phpcs.xml') then
				-- print("File exists")
			else
				os.execute('cp -r /home/declanb/Documents/php74-container/.phpcs.xml ' .. metadata.path .. '/.phpcs.xml')
			end

			os.execute('cp -r /home/declanb/Documents/php74-container/phpactor.json ' .. metadata.path .. '/.phpactor.json')

			vim.print('Switching to ' .. metadata.path)
			vim.print('switching from ' .. metadata.prev_path)

			transmit.remove_watch(metadata.prev_path)
			transmit.watch_directory(metadata.path)

			vim.cmd('clearjumps')
			vim.cmd('LspRestart')
			vim.print('Restarting LSP servers...')
			vim.cmd('NvimTreeRefresh')
		end
	end
end)
