return {
	'nvim-lualine/lualine.nvim',
	dependencies = { 'nvim-tree/nvim-web-devicons' },
	config = function()
		local BLUE         = '#7766ff'
		local CYAN         = '#33dbc3'
		local GREEN        = '#22ff22'
		local GREEN_LIGHT  = '#99ff99'
		local ICE          = '#95c5ff'
		local ORANGE       = '#ff8900'
		local ORANGE_LIGHT = '#f0af00'
		local PINK         = '#ffa6ff'
		local PINK_LIGHT   = '#ffb7b7'
		local PURPLE       = '#cf55f0'
		local PURPLE_LIGHT = '#af60af'
		local RED          = '#ee4a59'
		local RED_DARK     = '#a80000'
		local RED_LIGHT    = '#ff4090'
		local TEAL         = '#60afff'
		local TURQOISE     = '#2bff99'
		local YELLOW       = '#f0df33'

		local MODES =
		{
			['c']  = {'CMD   ', RED},
			['ce'] = {'NORM X', RED_DARK},
			['cv'] = {'EX    ', RED_LIGHT},
			['i']  = {'INSERT', GREEN},
			['ic'] = {'IN-CMP', GREEN_LIGHT},
			['n']  = {'NORMAL', PURPLE_LIGHT},
			['no'] = {'PNDING', PURPLE},
			['r']  = {':ENTER', CYAN},
			['r?'] = {':CONF ', CYAN},
			['rm'] = {'--MORE', ICE},
			['R']  = {'RPLACE', PINK},
			['Rv'] = {'VRTUAL', PINK_LIGHT},
			['s']  = {'SELECT', TURQOISE},
			['S']  = {'S LINE', TURQOISE},
			[''] = {'S BLK ', TURQOISE},
			['t']  = {'TRMNAL', ORANGE},
			['v']  = {'VISUAL', BLUE},
			['V']  = {'V LINE', BLUE},
			[''] = {'V BLK ', BLUE},
			['!']  = {'SHELL ', YELLOW},

			-- libmodal
			['WINDOW'] = TEAL,
			['DEBUG'] = ORANGE_LIGHT,
		}

		local MODE_HL_GROUP = 'LualineViMode'

		vim.api.nvim_create_autocmd('ModeChanged', {callback = function()
			require('lualine').refresh {scope = 'window',  place = {'statusline'}}
		end})

		require 'lualine'.setup({
			options = {
				component_separators = { left = '', right = ''},
				section_separators = { left = '', right = ''},
				theme = 'tokyonight',
			},
			sections = {
				lualine_a = {{
					function() -- auto change color according the vim mode
						local mode_color, mode_name

						if vim.g.libmodalActiveModeName then
							mode_name = vim.g.libmodalActiveModeName
							mode_color = MODES[mode_name]
						else
							local current_mode = MODES[vim.api.nvim_get_mode().mode]
							mode_name = current_mode[1]
							mode_color = current_mode[2]
						end

						vim.api.nvim_set_hl(0, MODE_HL_GROUP, {bg = mode_color, bold = true})

						return mode_name
					end,
					separator = { right = ''},
					color = MODE_HL_GROUP,
				}},
				lualine_b = {'branch', 'diff'},
				lualine_x = {'filetype'},
				lualine_z = {'selectioncount', 'searchcount', 'location'},
			},
			tabline = {
				lualine_a = {'buffers'},
				lualine_z = {'tabs'}
			},
		})
	end
}
