return {
	"echasnovski/mini.surround",
	version = false,
	keys = {
		{ "sa", mode = { "n", "v" }, desc = "Surround: add" },
		{ "sd", desc = "Surround: delete" },
		{ "sr", desc = "Surround: replace" },
		{ "sf", desc = "Surround: find right" },
		{ "sF", desc = "Surround: find left" },
		{ "sh", desc = "Surround: highlight" },
		{ "sn", desc = "Surround: update n_lines" },
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
