return {
	"williamboman/mason.nvim",
	run = ":MasonUpdate",
	config = function()
		require('mason').setup()
	end
}
