return {
	"williamboman/mason-lspconfig.nvim",
	config = function()
		require("mason-lspconfig").setup({
			ensure_installed = {
				"ansiblels",
				"awk_ls",
				"cssls",
				"docker_compose_language_service",
				"dockerls",
				"eslint",
				"html",
				"intelephense",
				"jsonls",
				"laravel_ls",
				"lemminx",
				"lua_ls",
				"pyright",
				"sqls",
				"tailwindcss",
				"ts_ls",
				"yamlls",
			},
		})
	end,
}
