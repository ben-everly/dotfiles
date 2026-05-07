return {
	"echasnovski/mini.surround",
	version = false,
	keys = {
		{ "sa", mode = { "n", "v" }, desc = "Add surrounding" },
		{ "sd", desc = "Delete surrounding" },
		{ "sr", desc = "Replace surrounding" },
		{ "sf", desc = "Find surrounding (right)" },
		{ "sF", desc = "Find surrounding (left)" },
		{ "sh", desc = "Highlight surrounding" },
		{ "sn", desc = "Update n_lines" },
	},
	opts = {
		custom_surroundings = {
			-- Press <CR> as the surround char to wrap with newlines
			-- (port of vim-surround's surround_13 = "\n\r\n")
			["\r"] = {
				output = { left = "\n", right = "\n" },
			},
		},
	},
}
