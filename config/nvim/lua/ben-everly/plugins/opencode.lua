return {
	"NickVanDyke/opencode.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"MunifTanjim/nui.nvim",
	},
	config = function()
		---@type opencode.Opts
		vim.g.opencode_opts = {
			provider = {
				enabled = "wezterm",
				wezterm = {
					direction = "right",
				},
			},
		}

		vim.o.autoread = true

		local function focus_opencode_pane()
			vim.defer_fn(function()
				vim.fn.system("wezterm cli activate-pane-direction right")
			end, 100)
		end

		vim.keymap.set({ "n", "x" }, "<leader>ai", function()
			require("opencode").ask("")
		end, { desc = "AI Ask" })

		vim.keymap.set({ "n", "x" }, "<leader>aa", function()
			require("opencode").select()
		end, { desc = "AI Action" })

		vim.keymap.set({ "n", "t" }, "<leader>at", function()
			require("opencode").toggle()
			focus_opencode_pane()
		end, { desc = "AI Toggle" })

		vim.keymap.set({ "n", "x" }, "<leader>ar", function()
			focus_opencode_pane()
			return require("opencode").operator("@this ")
		end, { expr = true, desc = "AI Range" })

		vim.keymap.set("n", "<leader>al", function()
			focus_opencode_pane()
			return require("opencode").operator("@this ") .. "_"
		end, { expr = true, desc = "AI Line" })
	end,
}
