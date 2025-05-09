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
	end,
}
