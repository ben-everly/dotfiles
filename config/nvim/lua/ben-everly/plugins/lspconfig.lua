return {
	'neovim/nvim-lspconfig',
	after = 'mason-lspconfig.nvim',
	config = function()
		vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
		vim.keymap.set('n', '[e', vim.diagnostic.goto_prev)
		vim.keymap.set('n', ']e', vim.diagnostic.goto_next)
		vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)
		vim.api.nvim_create_autocmd('LspAttach', {
			group = vim.api.nvim_create_augroup('UserLspConfig', {}),
			callback = function(ev)
				vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

				local opts = { buffer = ev.buf }
				vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
				vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
				vim.keymap.set({'n', 'v'}, 'K', vim.lsp.buf.hover, opts)
				vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
				vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
				vim.keymap.set('n', '<c-k>', vim.lsp.buf.signature_help, opts)
				vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
				vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
				vim.keymap.set('n', '<space>wl', function()
					print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
				end, opts)
				vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
				vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
				vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
				vim.keymap.set('n', '<c-f>', function()
					vim.lsp.buf.format { async = true }
				end, opts)
			end,
		})
		local lspconfig = require 'lspconfig'
		require('mason-lspconfig').setup_handlers {
			function (server_name)
				lspconfig[server_name].setup {}
			end,
			['intelephense'] = function ()
				lspconfig.intelephense.setup {
					settings = {
						intelephense = {
							licenceKey = vim.env.INTELEPHENSE_KEY,
						},
					},
				}
			end,
			["lua_ls"] = function ()
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
