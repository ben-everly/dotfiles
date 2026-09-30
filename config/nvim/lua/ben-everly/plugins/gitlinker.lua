return {
	"linrongbin16/gitlinker.nvim",
	config = function()
		require("gitlinker").setup()

		vim.keymap.set("n", "<leader>gh", function()
			require("gitlinker").link({ action = require("gitlinker.actions").system, linesep = false })
		end, { desc = "Git: open file in browser" })

		vim.keymap.set("v", "<leader>gh", function()
			require("gitlinker").link({ action = require("gitlinker.actions").system })
		end, { desc = "Git: open line(s) in browser" })

		vim.keymap.set({ "n", "v" }, "<leader>gH", function()
			require("gitlinker").link({ action = require("gitlinker.actions").clipboard })
		end, { desc = "Git: copy link to clipboard" })
	end,
}
