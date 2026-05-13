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
				end, { expr = true })

				map("n", "[g", function()
					if vim.wo.diff then
						return "[g"
					end
					vim.schedule(function()
						gs.prev_hunk()
					end)
					return "<Ignore>"
				end, { expr = true })

				map("n", "<leader>ga", gs.stage_hunk)
				map("v", "<leader>ga", function()
					gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
				end)
				map("n", "<leader>gA", gs.stage_buffer)
				map("n", "<leader>gx", gs.reset_hunk)
				map("v", "<leader>gx", function()
					gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
				end)
				map("n", "<leader>gX", gs.reset_buffer)
				map("n", "<leader>gu", gs.undo_stage_hunk)
				map("n", "<leader>gp", gs.preview_hunk_inline)
				map("n", "<leader>GB", function()
					gs.blame_line({ full = true })
				end)
				map("n", "<leader>gB", gs.blame)
				map("n", "<leader>gd", gs.diffthis)
				map("n", "<leader>gD", function()
					gs.diffthis("~")
				end)
				map("n", "<leader>gP", gs.toggle_deleted)

				map({ "o", "x" }, "ig", ":<C-U>Gitsigns select_hunk<CR>")
			end,
		})
	end,
}
