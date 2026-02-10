return {
	"WhoIsSethDaniel/mason-tool-installer.nvim",
	dependencies = { "williamboman/mason.nvim" },
	config = function()
		require("mason-tool-installer").setup({
			ensure_installed = {
				-- LSPs
				"ansiblels",
				"awk_ls",
				"cssls",
				"docker_compose_language_service",
				"dockerls",
				"eslint",
				"html",
				"intelephense",
				"phpactor",
				"jsonls",
				"laravel_ls",
				"lemminx",
				"lua_ls",
				"pyright",
				"sqls",
				"tailwindcss",
				"ts_ls",
				"yamlls",

				-- Formatters
				"blade-formatter",
				"pint",
				"prettierd",
				"sql-formatter",
				"stylua",
				"taplo",

				-- Linters
				"markdownlint",
				"phpstan",
				"phpmd",
			},
			auto_update = true,
			run_on_start = true,
		})
	end,
}
