function _G.previous_char_is_whitespace()
	local col = vim.fn.col('.') - 1
	return col == 0 or vim.fn.getline('.'):sub(col, col):match('%s')
end

return {
	'hrsh7th/nvim-cmp',
	dependencies = {
		'onsails/lspkind.nvim',
	},
	opts = function()
		local cmp = require 'cmp'
		return {
			formatting = {
				format = require('lspkind').cmp_format({
					mode = 'symbol',
					symbol_map = {
						Text = ' ',
						Method = ' ',
						Function = ' ',
						Constructor = ' ',
						Field = ' ',
						Variable = ' ',
						Class = ' ',
						Interface = ' ',
						Module = ' ',
						Property = ' ',
						Unit = ' ',
						Value = ' ',
						Enum = ' ',
						Keyword = ' ',
						Snippet = ' ',
						Color = ' ',
						File = ' ',
						Reference = ' ',
						Folder = ' ',
						EnumMember = ' ',
						Constant = ' ',
						Struct = ' ',
						Event = ' ',
						Operator = ' ',
						TypeParameter = ' ',
					}
				})
			},
			mapping = cmp.mapping.preset.insert({
				['<C-k>'] = cmp.mapping.scroll_docs(-4),
				['<C-j>'] = cmp.mapping.scroll_docs(4),
				['<C-Space>'] = function()
					if cmp.visible() then
						cmp.close()
					else
						cmp.complete()
					end
				end,
				['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
				['<Tab>'] = function(fallback)
					if cmp.visible() then
						cmp.select_next_item()
					elseif not previous_char_is_whitespace() then
						cmp.complete()
					else
						fallback()
					end
				end,
				['<S-Tab>'] = function(fallback)
					if cmp.visible() then
						cmp.select_prev_item()
					elseif not previous_char_is_whitespace() then
						cmp.complete()
					else
						fallback()
					end
				end,
			}),
			sources = cmp.config.sources({
				{ name = 'nvim_lsp' },
				{ name = 'lazydev', group_index = 0 },
			}),
		}
	end
}
