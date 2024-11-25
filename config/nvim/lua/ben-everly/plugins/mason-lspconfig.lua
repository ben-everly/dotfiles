return {
	'williamboman/mason-lspconfig.nvim',
	config = function()
		require('mason-lspconfig').setup({
			ensure_installed = {
				'ansiblels',
				'cssls',
				'docker_compose_language_service',
				'dockerls',
				'eslint',
				'html',
				'intelephense',
				'jsonls',
				'lemminx',
				'lua_ls',
				'sqls',
				'tailwindcss',
				'ts_ls',
				'yamlls',
			}
		})
		local lspconfig = require('lspconfig')
		require('mason-lspconfig').setup_handlers {
			function(server_name)
				lspconfig[server_name].setup {}
			end,
			['sqls'] = function ()
				lspconfig.sqls.setup{
					on_attach = function(client, bufnr)
						require('sqls').on_attach(client, bufnr)
					end
				}
			end,
		}
	end,
}
