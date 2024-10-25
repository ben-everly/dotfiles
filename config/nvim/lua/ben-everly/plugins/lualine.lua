return {
	'nvim-lualine/lualine.nvim',
	dependencies = { 'nvim-tree/nvim-web-devicons' },
	config = function()
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
		}

		local function color ()
			local mode;
			if vim.g.libmodalActiveModeName then
				mode = vim.g.libmodalActiveModeName
			else
				mode = vim.api.nvim_get_mode().mode
			end
			local hl;
			if modes[mode] == nil then
				hl = 'lualine_a_normal'
			else
				hl = modes[mode][2]
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
					function()
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
				lualine_z = {{
					'tabs',
					tabs_color = {
						active = 'lualine_a_normal',
						inactive = 'lualine_a_inactive',
					},
				}},
			},
		})
	end
}
