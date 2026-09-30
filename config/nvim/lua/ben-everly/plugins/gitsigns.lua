return {
	"lewis6991/gitsigns.nvim",
	config = function()
		local function set_hl()
			vim.api.nvim_set_hl(0, "GitSignsAddInline", { link = "DiffAdd" })
			vim.api.nvim_set_hl(0, "GitSignsChangeInline", { link = "DiffChange" })
			vim.api.nvim_set_hl(0, "GitSignsDeleteInline", { link = "DiffDelete" })
			local nontext = vim.api.nvim_get_hl(0, { name = "NonText", link = false })
			vim.api.nvim_set_hl(0, "GitSignsCurrentLineBlame", { fg = nontext.fg, italic = true })
		end
		set_hl()
		vim.api.nvim_create_autocmd("ColorScheme", { callback = set_hl })

		require("gitsigns").setup({
			numhl = true,
			linehl = false,
			word_diff = true,
			current_line_blame = true,
			current_line_blame_opts = { virt_text_pos = "eol", delay = 100 },
			on_attach = function(bufnr)
				local gs = package.loaded.gitsigns

				local function map(mode, l, r, opts)
					opts = opts or {}
					opts.buffer = bufnr
					vim.keymap.set(mode, l, r, opts)
				end

				map("n", "]g", function()
					if vim.wo.diff then
						return "]g"
					end
					vim.schedule(function()
						gs.next_hunk()
					end)
					return "<Ignore>"
				end, { expr = true, desc = "Git: next hunk" })

				map("n", "[g", function()
					if vim.wo.diff then
						return "[g"
					end
					vim.schedule(function()
						gs.prev_hunk()
					end)
					return "<Ignore>"
				end, { expr = true, desc = "Git: previous hunk" })

				map("n", "<leader>ga", gs.stage_hunk, { desc = "Git: stage hunk" })
				map("v", "<leader>ga", function()
					gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
				end, { desc = "Git: stage selected lines" })
				map("n", "<leader>gA", gs.stage_buffer, { desc = "Git: stage buffer" })
				map("n", "<leader>gx", gs.reset_hunk, { desc = "Git: reset hunk" })
				map("v", "<leader>gx", function()
					gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
				end, { desc = "Git: reset selected lines" })
				map("n", "<leader>gX", gs.reset_buffer, { desc = "Git: reset buffer" })
				map("n", "<leader>gu", gs.undo_stage_hunk, { desc = "Git: undo stage hunk" })
				map("n", "<leader>gp", gs.preview_hunk_inline, { desc = "Git: preview hunk inline" })
				map("n", "<leader>GB", function()
					gs.blame_line({ full = true })
				end, { desc = "Git: blame line (full)" })
				map("n", "<leader>gB", gs.blame, { desc = "Git: blame buffer" })
				map("n", "<leader>gd", gs.diffthis, { desc = "Git: diff against index" })
				map("n", "<leader>gD", function()
					gs.diffthis("~")
				end, { desc = "Git: diff against last commit" })
				map("n", "<leader>gP", gs.toggle_deleted, { desc = "Git: toggle deleted lines" })

				map({ "o", "x" }, "ig", ":<C-U>Gitsigns select_hunk<CR>", { desc = "Git: select hunk" })
			end,
		})
	end,
}
