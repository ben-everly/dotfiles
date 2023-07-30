-- Unimplemented features:

-- Coc lsp mappings
-- vim.keymap.set('n', '<c-p>', ':CocList symbols<cr>')

-- Coc refactoring mappings
-- vim.keymap.set('n', '<leader>qf', ' <Plug>(coc-fix-current)')
-- vim.keymap.set('n', '<leader>cl', ' <Plug>(coc-codelens-action)')

-- Coc hover highlighting
-- vim.api.nvim_create_augroup('CocGroup', {})
--[[ vim.api.nvim_create_autocmd('CursorHold', {
			group = 'CocGroup',
			command = "silent call CocActionAsync('highlight')",
			desc = 'Highlight symbol under cursor on CursorHold',
}) ]]

--[[ {
	"php-cs-fixer.activateTool": "pint",
	"Lua.telemetry.enable": false,
	"java.configuration.runtimes": [
		{
			"name": "JavaSE-17",
		"path": "/usr/lib/jvm/jdk-17",
		"default": true
		}
	],
} ]]

return {
	'neovim/nvim-lspconfig',
	config = function()
		vim.lsp.handlers["textDocument/hover"] =
		vim.lsp.with(
			vim.lsp.handlers.hover,
			{
				border = "single"
			}
		)
		vim.lsp.handlers["textDocument/signatureHelp"] =
		vim.lsp.with(
			vim.lsp.handlers.signature_help,
			{
				border = "single"
			}
		)

		vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float)
		vim.keymap.set('n', '[e', vim.diagnostic.goto_prev)
		vim.keymap.set('n', ']e', vim.diagnostic.goto_next)
		vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist)
		local signs = {
			Error = "󰀩",
			Warn = "",
			Hint = "󱧡",
			Info = "󰭺"
		}
		for type, icon in pairs(signs) do
			local hl = "DiagnosticSign" .. type
			vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
		end
		vim.diagnostic.config({
			virtual_text = {
				spacing = 2,
				prefix = "",
			},
			severity_sort = true,
			float = { float = "if_many" },
		})
		vim.api.nvim_create_autocmd('LspAttach', {
			group = vim.api.nvim_create_augroup('UserLspConfig', {}),
			callback = function(ev)
				vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

				local opts = { buffer = ev.buf }
				vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
				vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
				vim.keymap.set({ 'n', 'v' }, 'K', vim.lsp.buf.hover, opts)
				vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
				vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
				vim.keymap.set('n', '<c-k>', vim.lsp.buf.signature_help, opts)
				vim.keymap.set('n', '<leader>Wa', vim.lsp.buf.add_workspace_folder, opts)
				vim.keymap.set('n', '<leader>Wr', vim.lsp.buf.remove_workspace_folder, opts)
				vim.keymap.set('n', '<leader>Wl', function()
					print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
				end, opts)
				vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, opts)
				vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
				vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, opts)
				vim.keymap.set('n', '<c-f>', function()
					vim.lsp.buf.format {
						async = true,
						filter = function(client)
							if vim.lsp.get_active_clients({
									bufnr = ev.buf,
									name = 'null-ls',
								})[1].server_capabilities.documentFormattingProvider then
								return client.name == 'null-ls'
							end
							return true
						end
					}
				end, opts)
				vim.keymap.set('v', '<c-f>', function()
					vim.lsp.buf.format {
						async = true,
						filter = function(client)
							if vim.lsp.get_active_clients({
									bufnr = ev.buf,
									name = 'null-ls',
								})[1].server_capabilities.documentRangeFormattingProvider then
								return client.name == 'null-ls'
							end
							return true
						end
					}
				end)
			end,
		})
		local lspconfig = require 'lspconfig'
		require('mason-lspconfig').setup_handlers {
			function(server_name)
				lspconfig[server_name].setup {}
			end,
			["lua_ls"] = function()
				lspconfig.lua_ls.setup {
					settings = {
						Lua = {
							diagnostics = {
								globals = { "vim" }
							},
						},
					},
				}
			end,
		}
	end,
}
