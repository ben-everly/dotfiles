return {
	"echasnovski/mini.ai",
	version = false,
	event = "VeryLazy",
	config = function()
		-- Build separator textobjects with targets.vim-style whitespace trim:
		-- `i,` selects only the non-whitespace content between the surrounding commas.
		local separators = {}
		for _, c in ipairs({ ",", ".", ";", ":", "|", "/", "\\", "*", "+", "-", "=" }) do
			local outside = vim.pesc(c)
			local inside = c == "\\" and "%\\" or c
			separators[c] = {
				"()" .. outside .. "%s*()[^" .. inside .. "]-()%s*" .. outside .. "()",
			}
		end
		require("mini.ai").setup({
			custom_textobjects = separators,
		})
	end,
}
