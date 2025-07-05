return {
	"rgroli/other.nvim",
	config = function()
		require("other-nvim").setup({
			mappings = {
				"livewire",
				"laravel",
				{
					pattern = "/app/(.*)/(.*).php",
					target = "/tests/Unit/app/%1/%2Test.php",
					context = "unit test",
				},
				{
					pattern = "/app/(.*)/(.*).php",
					target = "/tests/Feature/%1/%2Test.php",
					context = "feature test",
				},
			},
		})
		vim.keymap.set("n", "go", "<cmd>Other<CR>", { silent = true, desc = "Go to other file" })
	end,
}
