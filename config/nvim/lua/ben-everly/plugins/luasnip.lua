return {
	"L3MON4D3/LuaSnip",
	version = "*",
	config = function()
		vim.keymap.set("n", "gs", require("luasnip.loaders").edit_snippet_files)
		local ls = require("luasnip")
		vim.keymap.set({ "i", "s", "n" }, "<C-j>", function()
			ls.jump(1)
		end, { silent = true })
		vim.keymap.set({ "i", "s", "n" }, "<C-k>", function()
			ls.jump(-1)
		end, { silent = true })

		vim.keymap.set({ "i", "s" }, "<c-e>", function()
			if ls.choice_active() then
				ls.change_choice(1)
			end
		end, { silent = true })
	end,
}
