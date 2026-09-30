return {
	"nvim-telescope/telescope.nvim",
	dependencies = "nvim-lua/plenary.nvim",
	config = function()
		local builtin = require("telescope.builtin")
		-- send the whole picker result to trouble instead of picking one item
		local open_with_trouble = function(...)
			return require("trouble.sources.telescope").open(...)
		end
		vim.keymap.set("n", "<leader>ff", function()
			if vim.fn.finddir(".git", vim.fn.getcwd() .. ";") ~= "" then
				builtin.git_files()
			else
				builtin.find_files()
			end
		end, { desc = "Find: files" })
		vim.keymap.set("n", "<leader>fF", builtin.find_files, { desc = "Find: all files" })
		vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Find: grep" })
		vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Find: buffers" })
		vim.keymap.set("n", "<leader>fm", builtin.marks, { desc = "Find: marks" })
		vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Find: help" })
		vim.keymap.set("n", "<leader>fj", builtin.jumplist, { desc = "Find: jumplist" })
		vim.keymap.set("n", "<leader>fr", builtin.registers, { desc = "Find: registers" })
		vim.keymap.set("n", "<leader>f/", builtin.search_history, { desc = "Find: search history" })
		vim.keymap.set("n", "<leader>gb", builtin.git_branches, { desc = "Git: branches" })
		vim.keymap.set("n", "<leader>gl", builtin.git_commits, { desc = "Git: commits" })
		vim.keymap.set("n", "<leader>gL", builtin.git_bcommits, { desc = "Git: buffer commits" })
		vim.keymap.set("n", "<leader>fGs", builtin.git_status, { desc = "Git: status files" })
		vim.keymap.set("n", "<leader>fGS", builtin.git_stash, { desc = "Git: stashes" })
		vim.keymap.set("n", "<leader>b", builtin.treesitter, { desc = "Find: treesitter symbols" })
		vim.keymap.set("n", "<leader>fs", builtin.lsp_workspace_symbols, { desc = "Find: workspace symbols" })
		vim.keymap.set("n", "<leader>fS", builtin.lsp_document_symbols, { desc = "Find: document symbols" })
		vim.keymap.set("n", "<leader>fd", builtin.diagnostics, { desc = "Find: diagnostics" })
		vim.keymap.set("n", "<leader>fP", builtin.builtin, { desc = "Find: pickers" })
		vim.keymap.set("n", "<leader>fc", builtin.commands, { desc = "Find: commands" })
		vim.keymap.set("n", "<leader>fk", builtin.keymaps, { desc = "Find: keymaps" })
		vim.keymap.set("n", "<leader>fq", builtin.quickfix, { desc = "Find: quickfix" })
		vim.keymap.set("n", "<leader>fl", builtin.loclist, { desc = "Find: loclist" })
		vim.keymap.set("n", "<leader>fa", builtin.resume, { desc = "Find: resume last picker" })
		vim.keymap.set("n", "gd", builtin.lsp_definitions, { desc = "LSP: go to definition" })
		vim.keymap.set("n", "gr", builtin.lsp_references, { desc = "LSP: go to references" })
		vim.keymap.set("n", "gi", builtin.lsp_implementations, { desc = "LSP: go to implementation" })
		vim.keymap.set("n", "<leader>D", builtin.lsp_type_definitions, { desc = "LSP: go to type definition" })
		require("telescope").setup({
			defaults = {
				layout_strategy = "center",
				sorting_strategy = "ascending",
				mappings = {
					i = {
						["<C-j>"] = "move_selection_next",
						["<C-k>"] = "move_selection_previous",
						["<C-t>"] = open_with_trouble,
					},
					n = { ["<C-t>"] = open_with_trouble },
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
				keymaps = {
					layout_config = { width = 0.9 },
					-- the picker sizes the lhs column to the longest lhs (<Plug> maps run
					-- 40+ chars), pushing desc off screen; width_lhs can't be set directly
					entry_maker = require("telescope.make_entry").gen_from_keymaps({ width_lhs = 16 }),
				},
				commands = { layout_config = { width = 0.9 } },
			},
		})
	end,
}
