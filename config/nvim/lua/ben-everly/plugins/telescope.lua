return {
	"nvim-telescope/telescope.nvim",
	dependencies = "nvim-lua/plenary.nvim",
	config = function()
		local builtin = require("telescope.builtin")
		vim.keymap.set("n", "<leader>ff", function()
			if vim.fn.finddir(".git", vim.fn.getcwd() .. ";") ~= "" then
				builtin.git_files()
			else
				builtin.find_files()
			end
		end)
		vim.keymap.set("n", "<leader>fF", builtin.find_files)
		vim.keymap.set("n", "<leader>fg", builtin.live_grep)
		vim.keymap.set("n", "<leader>fb", builtin.buffers)
		vim.keymap.set("n", "<leader>fm", builtin.marks)
		vim.keymap.set("n", "<leader>fh", builtin.help_tags)
		vim.keymap.set("n", "<leader>fj", builtin.jumplist)
		vim.keymap.set("n", "<leader>fr", builtin.registers)
		vim.keymap.set("n", "<leader>f/", builtin.search_history)
		vim.keymap.set("n", "<leader>gb", builtin.git_branches)
		vim.keymap.set("n", "<leader>gl", builtin.git_commits)
		vim.keymap.set("n", "<leader>gL", builtin.git_bcommits)
		vim.keymap.set("n", "<leader>fGs", builtin.git_status)
		vim.keymap.set("n", "<leader>fGS", builtin.git_stash)
		vim.keymap.set("n", "<leader>b", builtin.treesitter)
		vim.keymap.set("n", "<leader>fs", builtin.lsp_workspace_symbols)
		vim.keymap.set("n", "<leader>fd", builtin.diagnostics)
		vim.keymap.set("n", "<leader>fP", builtin.builtin)
		vim.keymap.set("n", "<leader>fq", builtin.quickfix)
		vim.keymap.set("n", "<leader>fl", builtin.loclist)
		vim.keymap.set("n", "<leader>fa", builtin.resume)
		vim.keymap.set("n", "gd", builtin.lsp_definitions)
		vim.keymap.set("n", "gr", builtin.lsp_references)
		vim.keymap.set("n", "gi", builtin.lsp_implementations)
		vim.keymap.set("n", "<leader>D", builtin.lsp_type_definitions)
		require("telescope").setup({
			defaults = {
				layout_strategy = "center",
				sorting_strategy = "ascending",
				mappings = {
					i = {
						["<C-j>"] = "move_selection_next",
						["<C-k>"] = "move_selection_previous",
					},
				},
			},
			pickers = {
				find_files = { hidden = true, no_ignore = true },
				marks = {
					mappings = {
						i = { ["<M-d>"] = require("telescope.actions").delete_mark },
						n = { ["dd"] = require("telescope.actions").delete_mark },
					},
				},
			},
		})
	end,
}
