return {
    'jay-babu/mason-null-ls.nvim',
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "williamboman/mason.nvim",
      "nvimtools/none-ls.nvim",
    },
	config = function()
		require('mason-null-ls').setup {
			ensure_installed = {
				'markdownlint',
				'phpstan',
				'blade-formatter',
				'pint',
				'prettierd',
				'sql-formatter'
			},
			automatic_installation = false,
			handlers = {},
		}
	end,
}
