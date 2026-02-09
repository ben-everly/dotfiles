return {
	"rgroli/other.nvim",
	config = function()
		require("other-nvim").setup({
			mappings = {
				"laravel",
				{
					pattern = "/app/Livewire/(.*).php",
					target = "/resources/views/livewire/%1.blade.php",
					context = "view",
					transformer = "camelToKebap",
				},
				{
					pattern = "/app/Livewire/(.*).php",
					target = "/resources/views/livewire/%1/",
					context = "view",
					transformer = "camelToKebap",
				},
				{
					pattern = "/resources/views/livewire/(.*).blade.php",
					target = "/app/Livewire/%1.php",
					context = "component",
					transformer = "kebapToCamel",
				},
				{
					pattern = "/resources/views/livewire/(.*)/.*.blade.php",
					target = "/app/Livewire/%1.php",
					context = "component",
					transformer = "kebapToCamel",
				},
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
