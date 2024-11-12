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

		local function mode_color ()
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

		vim.api.nvim_create_autocmd('ModeChanged', {callback = function()
			require('lualine').refresh {scope = 'window',  place = {'statusline'}}
		end})

		require 'lualine'.setup({
			options = {
				component_separators = '',
				section_separators = '',
				theme = 'tokyonight',
			},
			sections = {
				lualine_a = {},
				lualine_b = {},
				lualine_c = {
					{
						function()
							return '▊'
						end,
						color = function()
							return { fg = mode_color() }
						end,
						padding = { left = 0, right = 0 },
					},
					{
						'filetype',
						icon_only = true,
						padding = { left = 1, right = 0 },
					},
					{
						'filename',
						path = 1,
						padding = { left = 0, right = 1 },
					},
					{
						'progress',
					},
					{
						'location',
					},
					{
						'diagnostics',
						sources = { 'nvim_diagnostic' },
						symbols = { error = ' ', warn = ' ', info = ' ' },
					},
				},
				lualine_x = {
					{
						'branch',
						icon = '',
					},
					{
						'diff',
						symbols = { added = ' ', modified = '󰝤 ', removed = ' ' },
					},
					{
						'selectioncount',
					},
					{
						'searchcount',
					},
					{
						function()
							return '▊'
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
				lualine_a = {{
					'buffers',
				}},
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
