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
			['c']  = {'COMMAND', 'lualine_a_command'},
			['ce'] = {'NORM EX', 'lualine_a_terminal'},
			['cv'] = {'EX     ', 'lualine_a_terminal'},
			['t']  = {'TERMNAL', 'lualine_a_terminal'},
			['!']  = {'SHELL  ', 'lualine_a_terminal'},
			['i']  = {'INSERT ', 'lualine_a_insert'},
			['ic'] = {'INS-CMP', 'lualine_a_insert'},
			['n']  = {'NORMAL ', 'lualine_a_normal'},
			['no'] = {'PENDING', 'lualine_a_normal'},
			['r']  = {'ENTER  ', 'lualine_a_normal'},
			['r?'] = {'CONFIRM', 'lualine_a_normal'},
			['rm'] = {'--MORE ', 'lualine_a_normal'},
			['R']  = {'REPLACE', 'lualine_a_replace'},
			['Rv'] = {'VIRTUAL', 'lualine_a_replace'},
			['s']  = {'SELECT ', 'lualine_a_visual'},
			['S']  = {'S LINE ', 'lualine_a_visual'},
			[''] = {'S BLK  ', 'lualine_a_visual'},
			['v']  = {'VISUAL ', 'lualine_a_visual'},
			['V']  = {'V LINE ', 'lualine_a_visual'},
			[''] = {'V BLK  ', 'lualine_a_visual'},

			-- libmodal
			['WINDOW'] = {'WINDOW ', 'lualine_a_replace'},
			['DEBUG'] = {'DEBUG  ', 'lualine_a_command'},
		}

		local function color ()
			local hl;
			if vim.g.libmodalActiveModeName then
				hl = modes[vim.g.libmodalActiveModeName][2]
			else
				hl = modes[vim.api.nvim_get_mode().mode][2]
			end
			return vim.fn.synIDattr(vim.fn.synIDtrans(vim.fn.hlID(hl)), "bg#")
		end

		local function fg_color ()
			return { fg = color() }
		end

		local function bg_color ()
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
				lualine_y = {{
					'progress',
					color = fg_color,
				}},
				-- synIDattr(synIDtrans(hlID("lualine_a_command")), "fg#")
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
