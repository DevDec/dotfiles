local lsp_zero = require('lsp-zero')

lsp_zero.on_attach(function(client, bufnr)
	-- see :help lsp-zero-keybindings
	-- to learn the available actions
	lsp_zero.default_keymaps({ buffer = bufnr })
end)

local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())

local lspconfig = require('lspconfig')

local intelephenseCapabilities = vim.lsp.protocol.make_client_capabilities()

for key, value in pairs(intelephenseCapabilities.textDocument) do
	if (key ~= "documentSymbol") then
		intelephenseCapabilities.textDocument[key] = false
	end
end

local disabled_lsp_capabilties = {
	intelephense = {
		'declaration',
		-- 'rename',
		'definition',
		'desclaration',
		-- 'diagnostic',
		-- 'codeAction',
		'implementation',
		-- 'documentHighlight',
		-- 'formatting',
		-- 'hover',
		-- 'inlayHint',
		-- 'publishDiagnostics',
		-- 'rangeFormatting',
		'signatureHelp',
		-- 'typeDefinition',
		'references',
		-- 'window',
		-- 'workspace',
	},
	phpactor = {
		'documentSymbol',
		-- 'implementation',
		-- 'declaration',
		'rename',
		-- 'definition',
		'diagnostic',
		'codeAction',
		'documentHighlight',
		'formatting',
		'hover',
		'inlayHint',
		-- 'publishDiagnostics',
		'rangeFormatting',
		-- 'signatureHelp',
		'typeDefinition',
		-- 'references',
		'window',
		'workspace',
	}
}

local on_attach = function(client, buffer)
	if client == "phpactor" then
		local ns = vim.lsp.diagnostic.get_namespace(client.id)
		vim.documentSymbol.disable(nil, ns)
	end

	if disabled_lsp_capabilties[client.name] ~= nil then
		for key, value in pairs(disabled_lsp_capabilties[client.name]) do
			if client.server_capabilities[value .. "Provider"] ~= nil then
				client.server_capabilities[value .. "Provider"] = nil
			end
		end
	end
	config.flags.allow_incremental_sync = true
end

-- -- PHP
-- lspconfig.intelephense.setup({
--   capabilities = capabilities,
--   -- on_attach = on_attach,
--   settings = {
-- 	  intelephense = {
-- 		  environment = {
-- 			  includePaths = {
-- 				  "/home/declanb/Documents/Projects/phpactor/vendor/jetbrains/phpstorm-stubs/",
-- 			  }
-- 		  }
-- 	  }
--   }
-- })

lspconfig.phpactor.setup({
	capabilities = capabilities,
	init_options = {
        -- ["language_server_phpstan.enabled"] = false,
        ["language_server_psalm.enabled"] = true,
		["language_server_psalm.bin"] = "/usr/bin/psalm",
		["language_server_psalm.error_level"] = 1,
		["language_server_php_cs_fixer.enabled"] = true,
		["php_code_sniffer.enabled"] = true,
		["language_server_php_cs_fixer.config"] = "/home/declanb/Documents/Projects/phpactor/.php-cs-fixer.dist.php",
		["language_server.diagnostic_outsource_timeout"] = 15,
		["language_server_php_cs_fixer.bin"] = "/home/declanb/.nix-profile/bin/php-cs-fixer",
	}
	-- on_attach = on_attach
})

-- XML
-- lspconfig.lemminx.setup({ capabilities = capabilities })

-- Twig
-- lspconfig.curlylint.setup({ capabilities = capabilities })
lspconfig.twiggy_language_server.setup({ capabilities = capabilities })

lspconfig.sqlls.setup {}

-- Yaml
-- lspconfig.yamlls.setup({ capabilities = capabilities })

lspconfig.eslint.setup({ capabilities = capabilities })

lspconfig.gopls.setup {}

lspconfig.lua_ls.setup {
	settings = {
		Lua = {
			runtime = {
				version = 'LuaJIT',
			},
			diagnostics = {
				globals = { 'vim' },
			},
			workspace = {
				library = {
					vim.api.nvim_get_runtime_file("", true),
					[vim.fn.expand('/home/declanb/Documents/Projects/transmit.nvim.git/main/')] = true
				},
			},
			telemetry = {
				enable = false,
			},
		},
	},
}

-- TypeScript/JavaScript
lspconfig.ts_ls.setup({ capabilities = capabilities })
--   capabilities = capabilities,
--   -- Enable "Take Over Mode" where volar will provide all JS/TS LSP services
--   -- This drastically improves the responsiveness of diagnostic updates on change
--   filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue' },
-- })

-- CSS/LESS/HTML
lspconfig.cssls.setup({ capabilities = capabilities })
-- lspconfig.html.setup({})

-- JSON
lspconfig.jsonls.setup({
	capabilities = capabilities,
	settings = {
		json = {
			schemas = require('schemastore').json.schemas(),
		},
	},
})

-- Docker
lspconfig.dockerls.setup({ capabilities = capabilities })
-- lspconfig.docker_compose_language_server.setup({ capabilities = capabilities })

-- Keymaps
vim.keymap.set('n', '<Leader>i', '<cmd>lua vim.diagnostic.open_float()<CR>')
vim.keymap.set('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>')
vim.keymap.set('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>')
vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>')
vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>')
vim.keymap.set('n', '<leader>t', '<cmd>lua vim.lsp.buf.type_definition()<CR>')
vim.keymap.set('n', 'gi', ':Telescope lsp_implementations show_line=false<CR>')
vim.keymap.set('n', 'gr', function()
	vim.cmd('Telescope lsp_references show_line=false')
end
)
vim.keymap.set('n', 'gci', ':Telescope lsp_incoming_calls<CR>')
vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>')
vim.keymap.set('n', '<leader>K', '<cmd>lua vim.lsp.buf.signature_help()<CR>')
vim.keymap.set('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>')
vim.keymap.set('n', '<Leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>')
vim.keymap.set('n', '<Leader>id', ':Telescope diagnostics bufnr=0<CR>')
vim.keymap.set('n', '<leader>tid', function()
  vim.diagnostic.enable(not vim.diagnostic.is_enabled())
end, { silent = true, noremap = true })

-- Diagnostic configuration
vim.diagnostic.config({
	virtual_text = false,
	float = {
		source = true,
	}
})

-- Sign configuration
-- vim.fn.sign_define('DiagnosticSignError', { text = '', texthl = 'DiagnosticSignError' })
-- vim.fn.sign_define('DiagnosticSignWarn', { text = '', texthl = 'DiagnosticSignWarn' })
-- vim.fn.sign_define('DiagnosticSignInfo', { text = '', texthl = 'DiagnosticSignInfo' })
-- vim.fn.sign_define('DiagnosticSignHint', { text = '', texthl = 'DiagnosticSignHint' })

-- vim.keymap.set('n', '<Leader>pcm', ':PhpactorMoveFile<CR>')
-- vim.keymap.set('n', '<Leader>pcom', ':PhpactorMoveFile<CR>')
-- vim.keymap.set('n', '<Leader>pcn', ':PhpactorClassNew<CR>')
--
