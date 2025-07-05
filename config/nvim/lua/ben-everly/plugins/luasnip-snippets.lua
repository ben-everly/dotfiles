return {
	"ben-everly/luasnip-snippets",
	branch = "main",
	config = function()
		require("luasnip.loaders.from_lua").lazy_load()
	end,
}
