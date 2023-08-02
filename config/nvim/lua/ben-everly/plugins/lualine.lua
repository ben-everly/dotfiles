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
			['c']  = {'CMD   ', 'lualine_a_command'},
			['ce'] = {'NORM X', 'lualine_a_terminal'},
			['cv'] = {'EX    ', 'lualine_a_terminal'},
			['t']  = {'TRMNAL', 'lualine_a_terminal'},
			['!']  = {'SHELL ', 'lualine_a_terminal'},
			['i']  = {'INSERT', 'lualine_a_insert'},
			['ic'] = {'IN-CMP', 'lualine_a_insert'},
			['n']  = {'NORMAL', 'lualine_a_normal'},
			['no'] = {'PNDING', 'lualine_a_normal'},
			['r']  = {':ENTER', 'lualine_a_normal'},
			['r?'] = {':CONF ', 'lualine_a_normal'},
			['rm'] = {'--MORE', 'lualine_a_normal'},
			['R']  = {'RPLACE', 'lualine_a_replace'},
			['Rv'] = {'VRTUAL', 'lualine_a_replace'},
			['s']  = {'SELECT', 'lualine_a_visual'},
			['S']  = {'S LINE', 'lualine_a_visual'},
			[''] = {'S BLK ', 'lualine_a_visual'},
			['v']  = {'VISUAL', 'lualine_a_visual'},
			['V']  = {'V LINE', 'lualine_a_visual'},
			[''] = {'V BLK ', 'lualine_a_visual'},

			-- libmodal
			['WINDOW'] = 'lualine_b_visual',
			['DEBUG'] = 'lualine_a_command',
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

						vim.api.nvim_set_hl(0, MODE_HL_GROUP, {link = mode_color})

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
