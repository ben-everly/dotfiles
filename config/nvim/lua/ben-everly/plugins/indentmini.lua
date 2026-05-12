return {
	"nvimdev/indentmini.nvim",

	event = { "BufReadPost", "BufNewFile" },
	opts = {
		char = "▏",
	},
	init = function()
		local function set_hl()
			vim.api.nvim_set_hl(0, "IndentLine", { link = "NonText" })
			vim.api.nvim_set_hl(0, "IndentLineCurrent", { link = "IndentLine" })
		end
		set_hl()
		vim.api.nvim_create_autocmd("ColorScheme", { callback = set_hl })
	end,
}
