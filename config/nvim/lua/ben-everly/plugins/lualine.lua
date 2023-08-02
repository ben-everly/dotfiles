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

		local modes =
		{
			['c']  = {'COMMAND', YELLOW},
			['ce'] = {'NORM EX', YELLOW},
			['cv'] = {'EX     ', YELLOW},
			['t']  = {'TERMNAL', YELLOW},
			['!']  = {'SHELL  ', YELLOW},
			['i']  = {'INSERT ', GREEN},
			['ic'] = {'INS-CMP', GREEN},
			['n']  = {'NORMAL ', BLUE},
			['no'] = {'PENDING', BLUE},
			['r']  = {'ENTER  ', BLUE},
			['r?'] = {'CONFIRM', BLUE},
			['rm'] = {'--MORE ', BLUE},
			['R']  = {'REPLACE', RED},
			['Rv'] = {'VIRTUAL', RED},
			['s']  = {'SELECT ', PURPLE},
			['S']  = {'S LINE ', PURPLE},
			[''] = {'S BLK  ', PURPLE},
			['v']  = {'VISUAL ', PURPLE},
			['V']  = {'V LINE ', PURPLE},
			[''] = {'V BLK  ', PURPLE},

			-- libmodal
			['WINDOW'] = {'WINDOW ', ORANGE},
			['DEBUG'] = {'DEBUG  ', TEAL},
		}

		local color = function ()
			if vim.g.libmodalActiveModeName then
				return modes[vim.g.libmodalActiveModeName][2]
			else
				return modes[vim.api.nvim_get_mode().mode][2]
			end
		end

		local fg_color = function()
			return { fg = color() }
		end

		local bg_color = function()
			return { bg = color() }
		end

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
						if vim.g.libmodalActiveModeName then
							return modes[vim.g.libmodalActiveModeName][1]
						else
							return modes[vim.api.nvim_get_mode().mode][1]
						end
					end,
					separator = { right = ''},
					color = bg_color,
				}},
				lualine_b = {{
					'branch',
					color = fg_color,
				}, {
					'diff',
				}},
				lualine_x = {'filetype'},
				lualine_y = {
					'progress',
					color = fg_color,
				},
				lualine_z = {{
					'selectioncount',
					color = bg_color,
				}, {
					'searchcount',
					color = bg_color,
				}, {
					'location',
					color = bg_color,
				}},
			},
			tabline = {
				lualine_a = {'buffers'},
				lualine_z = {'tabs'}
			},
		})
	end
}
