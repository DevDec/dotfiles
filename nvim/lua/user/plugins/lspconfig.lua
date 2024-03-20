-- Setup Mason to automatically install LSP servers
require('mason').setup()

local ensured_installs = {
  'phpactor@2022.11.12'
}

require('mason-lspconfig').setup({ ensure_installed = ensured_installs, automatic_installation = true })

local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())

local lspconfig = require('lspconfig')

-- PHP
lspconfig.intelephense.setup({
  capabilities = capabilities,
})

lspconfig.intelephense.handlers = {
    ['textDocument/documentSymbol'] = nil,
    ['textDocument/rename'] = nil,
    ['textDocument/definition'] = nil,
    ['textDocument/declaration'] = nil,
    ['textDocument/diagnostic'] = nil,
    ['textDocument/codeAction'] = nil,
    ['textDocument/documentHighlight'] = nil,
    ['textDocument/formatting'] = nil,
    ['textDocument/hover'] = nil,
    ['textDocument/implementation'] = nil,
    ['textDocument/inlayHint'] = nil,
    ['textDocument/publishDiagnostics'] = nil,
    ['textDocument/rangeFormatting'] = nil,
    ['textDocument/signatureHelp'] = nil,
    ['textDocument/typeDefinition'] = nil,
}

lspconfig.phpactor.setup({
  capabilities = capabilities,
  init_options = {
    ["symfony.enabled"] = true,
  },
 })

lspconfig.phpactor.handlers = {
  ['textDocument/references'] = nil,
}

-- XML
lspconfig.lemminx.setup({ capabilities = capabilities })

-- Twig
-- lspconfig.curlylint.setup({ capabilities = capabilities })
lspconfig.twiggy_language_server.setup({ capabilities = capabilities })

-- Yaml
lspconfig.yamlls.setup({ capabilities = capabilities })

lspconfig.eslint.setup({ capabilities = capabilities })

-- Lua
lspconfig.lua_ls.setup({ capabilities = capabilities })

-- TypeScript/JavaScript
lspconfig.tsserver.setup({ capabilities = capabilities })
-- lspconfig.volar.setup({
--   capabilities = capabilities,
--   -- Enable "Take Over Mode" where volar will provide all JS/TS LSP services
--   -- This drastically improves the responsiveness of diagnostic updates on change
--   filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue' },
-- })

-- CSS/LESS/HTML
lspconfig.cssls.setup({ capabilities = capabilities })
lspconfig.html.setup({
  capabilities = capabilities,
  filetypes = { 'html', 'twig', 'php', 'javascript', 'typescript'}
})
lspconfig.tailwindcss.setup({ capabilities = capabilities })

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

-- -- null-ls
-- require('null-ls').setup({
--   sources = {
--     require('null-ls').builtins.diagnostics.eslint_d.with({
--       condition = function(utils)
--         return utils.root_has_file({ '.eslintrc.js' })
--       end,
--     }),
--     require('null-ls').builtins.diagnostics.trail_space.with({ disabled_filetypes = { 'NvimTree' } }),
--     require('null-ls').builtins.formatting.eslint_d.with({
--       condition = function(utils)
--         return utils.root_has_file({ '.eslintrc.js' })
--       end,
--     }),
--     require('null-ls').builtins.formatting.prettierd,
--   },
-- })

-- require('mason-null-ls').setup({ automatic_installation = true })

-- Keymaps
vim.keymap.set('n', '<Leader>d', '<cmd>lua vim.diagnostic.open_float()<CR>')
vim.keymap.set('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>')
vim.keymap.set('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>')
vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>')
vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>')
vim.keymap.set('n', '<leader>t', '<cmd>lua vim.lsp.buf.type_definition()<CR>')
vim.keymap.set('n', 'gi', ':Telescope lsp_implementations show_line=false<CR>') 
vim.keymap.set('n', 'gr', ':Telescope lsp_references show_line=false<CR>')
vim.keymap.set('n', 'gci', ':Telescope lsp_incoming_calls<CR>') 
vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>')
vim.keymap.set('n', '<leader>K', '<cmd>lua vim.lsp.buf.signature_help()<CR>')
vim.keymap.set('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>')
vim.keymap.set('n', '<Leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>')
vim.keymap.set('n', '<Leader>dd', ':Telescope diagnostics<CR>')

-- Commands
-- vim.api.nvim_create_user_command('Format', vim.lsp.buf.formatting, {})

-- Diagnostic configuration
vim.diagnostic.config({
  virtual_text = false,
  float = {
    source = true,
  }
})

-- Sign configuration
vim.fn.sign_define('DiagnosticSignError', { text = '', texthl = 'DiagnosticSignError' })
vim.fn.sign_define('DiagnosticSignWarn', { text = '', texthl = 'DiagnosticSignWarn' })
vim.fn.sign_define('DiagnosticSignInfo', { text = '', texthl = 'DiagnosticSignInfo' })
vim.fn.sign_define('DiagnosticSignHint', { text = '', texthl = 'DiagnosticSignHint' })
