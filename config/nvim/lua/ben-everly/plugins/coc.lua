return {
	'neoclide/coc.nvim',
	branch = 'release',
	config = function()
		vim.fn['coc#config']('intelephense.licenceKey', vim.env.INTELEPHENSE_KEY)
		vim.g.coc_global_extensions = {
			'coc-css',
			'coc-blade',
			'coc-docker',
			'coc-eslint',
			'coc-go',
			'coc-html',
			'coc-java',
			'coc-json',
			'coc-lists',
			'coc-markdownlint',
			'coc-markdown-preview-enhanced',
			'coc-sh',
			'coc-snippets',
			'coc-sql',
			'coc-tsserver',
			'coc-vimlsp',
			'coc-xml',
			'coc-yaml',
			'@yaegassy/coc-ansible',
			'@yaegassy/coc-tailwindcss3',
			'@yaegassy/coc-phpstan',
		}
		-- 'coc-spell-checker',
		-- 'coc-jsonc',

		-- Coc lsp mappings
		-- vim.api.nvim_create_user_command('Fold', "call CocAction('fold', <f-args>)", { nargs = '?' })
		vim.keymap.set('n', '<c-p>', ':CocList symbols<cr>')

		-- Coc refactoring mappings
		vim.keymap.set('n', '<leader>qf', ' <Plug>(coc-fix-current)')
		vim.keymap.set('n', '<leader>cl', ' <Plug>(coc-codelens-action)')

		-- Coc hover highlighting
		vim.api.nvim_create_augroup('CocGroup', {})
		vim.api.nvim_create_autocmd('CursorHold', {
			group = 'CocGroup',
			command = "silent call CocActionAsync('highlight')",
			desc = 'Highlight symbol under cursor on CursorHold',
		})

		-- Coc Autocomplete mappings
		local function replace_termcodes(str)
			return vim.api.nvim_replace_termcodes(str, true, false, true)
		end
		local function do_snippet_jump()
			return replace_termcodes("<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])<CR>")
		end
		function _G.tab()
			if vim.fn['coc#jumpable']() then
				return do_snippet_jump()
			end
		end

		function _G.enter()
			elseif vim.fn['coc#expandableOrJumpable']() == 1 then
				return do_snippet_jump()
		end
	end
}
