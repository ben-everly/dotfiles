return {
	"levouh/tint.nvim",
	config = function()
		require("tint").setup({
			tint = -40,
			---@diagnostic disable-next-line: assign-type-mismatch
			saturation = 0.92,
			tint_background_colors = false,
			highlight_ignore_patterns = {
				"WinSeparator",
				"VertSplit",
				"NeoTreeWinSeparator",
				"NeoTreeVertSplit",
				"Neogit",
			},
		})
	end,
}
