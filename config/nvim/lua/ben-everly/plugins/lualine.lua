return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		local colors = {
			bg = "#202328",
			fg = "#bbc2cf",
			yellow = "#ECBE7B",
			cyan = "#008080",
			darkblue = "#081633",
			green = "#98be65",
			orange = "#FF8800",
			violet = "#a9a1e1",
			magenta = "#c678dd",
			blue = "#51afef",
			red = "#ec5f67",
		}
		local modes = {
			["c"] = { colors["yellow"] },
			["ce"] = { colors["orange"] },
			["cv"] = { colors["orange"] },
			["t"] = { colors["orange"] },
			["!"] = { colors["orange"] },
			["i"] = { colors["green"] },
			["ic"] = { colors["green"] },
			["n"] = { colors["blue"] },
			["no"] = { colors["blue"] },
			["r"] = { colors["red"] },
			["r?"] = { colors["red"] },
			["rm"] = { colors["red"] },
			["R"] = { colors["cyan"] },
			["Rv"] = { colors["cyan"] },
			["s"] = { colors["magenta"] },
			["S"] = { colors["magenta"] },
			[""] = { colors["magenta"] },
			["v"] = { colors["magenta"] },
			["V"] = { colors["magenta"] },
			[""] = { colors["magenta"] },
		}

		local function mode_color()
			local mode = vim.api.nvim_get_mode().mode
			return modes[mode] and modes[mode][1] or colors["blue"]
		end

		vim.api.nvim_create_autocmd("ModeChanged", {
			callback = function()
				require("lualine").refresh({
					scope = "window",
					place = { "statusline" },
				})
			end,
		})

		require("lualine").setup({
			options = {
				component_separators = "",
				section_separators = "",
				theme = "gruvbox-material",
			},
			sections = {
				lualine_a = {},
				lualine_b = {},
				lualine_c = {
					{
						function()
							return "▊▊"
						end,
						color = function()
							return { fg = mode_color() }
						end,
						padding = { left = 0, right = 1 },
					},
					{
						"filetype",
						icon_only = true,
						padding = { left = 0, right = 0 },
					},
					{ "filename", path = 1, padding = { left = 0, right = 1 } },
					{ "progress" },
					{ "location" },
					{
						"diagnostics",
						sources = { "nvim_diagnostic" },
						symbols = { error = " ", warn = " ", info = " " },
					},
				},
				lualine_x = {
					{
						"diff",
						symbols = {
							added = " ",
							modified = "󰝤 ",
							removed = " ",
						},
					},
					{
						"branch",
						icon = "",
					},
					{ "selectioncount" },
					{ "searchcount" },
					{
						function()
							return "▊▊"
						end,
						color = function()
							return { fg = mode_color() }
						end,
						padding = { left = 0, right = 0 },
					},
				},
				lualine_y = {},
				lualine_z = {},
			},
			tabline = {
				lualine_c = { { "buffers", symbols = { alternate_file = "" } } },
				lualine_x = {
					{
						"tabs",
						tabs_color = {
							active = "lualine_c_normal",
							inactive = "lualine_c_inactive",
						},
					},
				},
			},
		})
	end,
}
