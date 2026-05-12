return {
	"echasnovski/mini.indentscope",
	version = false,
	event = { "BufReadPost", "BufNewFile" },
	opts = {
		symbol = "▏",
		options = { try_as_border = true },
		draw = { priority = 5000 },
	},
	init = function()
		local function set_hl()
			vim.api.nvim_set_hl(0, "MiniIndentscopeSymbol", { link = "Normal" })
		end
		set_hl()
		vim.api.nvim_create_autocmd("ColorScheme", { callback = set_hl })

		vim.api.nvim_create_autocmd("FileType", {
			pattern = {
				"help",
				"alpha",
				"dashboard",
				"neo-tree",
				"Trouble",
				"trouble",
				"lazy",
				"mason",
				"notify",
				"toggleterm",
				"lazyterm",
			},
			callback = function()
				vim.b.miniindentscope_disable = true
			end,
		})
		vim.api.nvim_create_autocmd("TermOpen", {
			callback = function()
				vim.b.miniindentscope_disable = true
			end,
		})
	end,
}
