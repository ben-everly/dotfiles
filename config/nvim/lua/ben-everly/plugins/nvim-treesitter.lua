return {
	'nvim-treesitter/nvim-treesitter',
	build = function()
		require('nvim-treesitter.install').update({ with_sync = true })()
	end,
	config = function()
		require 'nvim-treesitter.configs'.setup {
			auto_install = true,
			highlight = {
				enable = true,
			},
			indent = {
				enable = true,
			},
			incremental_selection = {
				enable = true,
				keymaps = {
					init_selection = 'gnn',
					scope_incremental = 'grc',
					node_incremental = '>',
					node_decremental = '<',
				},
			},
			-- TODO this should move to the textobjects config but
			-- calling setup again will override the rest of this
			textobjects = {
				select = {
					enable = true,
					lookahead = true,
					keymaps = {
						['af'] = '@function.outer',
						['if'] = '@function.inner',
						['ac'] = '@class.outer',
						['ic'] = '@class.inner',
						['ao'] = '@loop.outer',
						['io'] = '@loop.inner',
						['as'] = '@scope',
						['al'] = '@statement.outer'
					},
				},
				move = {
					enable = true,
					set_jumps = false,
					goto_next_start = {
						[']f'] = '@function.outer',
						[']c'] = '@class.outer',
						[']o'] = '@loop.outer',
						[']s'] = '@scope',
					},
					goto_next_end = {
						[']F'] = '@function.outer',
						[']C'] = '@class.outer',
						[']O'] = '@loop.outer',
						['[s'] = '@scope',
					},
					goto_previous_start = {
						['[f'] = '@function.outer',
						['[c'] = '@class.outer',
						['[o'] = '@loop.outer',
					},
					goto_previous_end = {
						['[F'] = '@function.outer',
						['[C'] = '@class.outer',
						['[O'] = '@loop.outer',
					},
				},
			},
		}
		vim.opt.foldmethod = 'expr'
		vim.wo.foldexpr = 'nvim_treesitter#foldexpr()'
	end
}
