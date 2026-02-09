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
			hooks = {
				filePickerBeforeShow = function(files)
					local status, _ = pcall(require, "telescope")
					if not status then
						return files
					end

					local pickers = require("telescope.pickers")
					local finders = require("telescope.finders")
					local conf = require("telescope.config").values

					pickers
						.new({}, {
							prompt_title = "Other Files",
							finder = finders.new_table({
								results = files,
								entry_maker = function(entry)
									local relative_path = vim.fn.fnamemodify(entry.filename, ":.")
									local max_len = 50
									if #relative_path > max_len then
										relative_path = "..." .. string.sub(relative_path, -max_len + 3)
									end

									return {
										value = entry,
										display = string.format("%-15s | %s", entry.context, relative_path),
										ordinal = entry.filename,
										path = entry.filename,
									}
								end,
							}),
							sorter = conf.generic_sorter({}),
							previewer = conf.file_previewer({}),
						})
						:find()

					return false
				end,
			},
		})
		vim.keymap.set("n", "go", "<cmd>Other<CR>", { silent = true, desc = "Go to other file" })
	end,
}
