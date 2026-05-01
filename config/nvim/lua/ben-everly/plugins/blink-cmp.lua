return {
	"saghen/blink.cmp",
	event = "InsertEnter",
	version = "*",
	dependencies = {
		"L3MON4D3/LuaSnip",
		"Kaiser-Yang/blink-cmp-git",
	},
	opts_extend = { "sources.default" },
	---@module 'blink.cmp'
	---@type blink.cmp.Config
	opts = {
		snippets = { preset = "luasnip" },
		keymap = {
			preset = "super-tab",
			["<C-u>"] = { "scroll_documentation_up", "fallback" },
			["<C-d>"] = { "scroll_documentation_down", "fallback" },
		},
		sources = {
			default = { "lsp", "snippets", "buffer", "path" },
			per_filetype = {
				gitcommit = { inherit_defaults = true, "git" },
				octo = { inherit_defaults = true, "git" },
			},
			providers = {
				git = {
					module = "blink-cmp-git",
					name = "Git",
					opts = {},
				},
			},
		},
	},
}
