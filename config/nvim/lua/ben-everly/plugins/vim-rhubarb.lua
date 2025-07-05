return {
	"tpope/vim-rhubarb",
	config = function()
		vim.keymap.set("n", "<leader>gH", ":GBrowse<CR>")
		vim.keymap.set("n", "<leader>gh", ":.GBrowse<CR>")
		vim.keymap.set("v", "<leader>gh", ":'<,'>GBrowse<cr>")
	end,
}
