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
			'coc-sumneko-lua',
			'coc-markdownlint',
			'coc-markdown-preview-enhanced',
			'coc-phpls',
			'coc-php-cs-fixer',
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
		vim.keymap.set('n', '[e', '<Plug>(coc-diagnostic-prev)', { silent = true })
		vim.keymap.set('n', ']e', '<Plug>(coc-diagnostic-next)', { silent = true })
		vim.keymap.set('n', '<leader>e', ':CocList diagnostics<cr>')
		vim.keymap.set('n', 'gd', '<Plug>(coc-definition)', { silent = true })
		vim.keymap.set('n', 'gy', '<Plug>(coc-type-definition)', { silent = true })
		vim.keymap.set('n', 'gi', '<Plug>(coc-implementation)', { silent = true })
		vim.keymap.set('n', 'gr', '<Plug>(coc-references)', { silent = true })
		vim.keymap.set({ 'x', 'o' }, 'if', '<Plug>(coc-funcobj-i)')
		vim.keymap.set({ 'x', 'o' }, 'af', '<Plug>(coc-funcobj-a)')
		vim.keymap.set({ 'x', 'o' }, 'ic', '<Plug>(coc-classobj-i)')
		vim.keymap.set({ 'x', 'o' }, 'ac', '<Plug>(coc-classobj-a)')
		vim.keymap.set({ 'n', 'x' }, '<C-s>', '<Plug>(coc-range-select)', { silent = true })
		vim.keymap.set('n', '<leader>b', ':CocList outline<cr>')
		vim.keymap.set('n', '<c-p>', ':CocList symbols<cr>')

		-- Coc refactoring mappings
		vim.api.nvim_create_user_command('Format', "call CocAction('format')", {})
		vim.api.nvim_create_user_command('OR', "call CocActionAsync('runCommand', 'editor.action.organizeImport')", {})
		vim.keymap.set('n', '<leader>rn', '<Plug>(coc-rename)')
		vim.keymap.set('x', '<c-f>', ' <Plug>(coc-format-selected)')
		vim.keymap.set('n', '<c-f>', '<Plug>(coc-format)')
		vim.keymap.set('x', '<leader>a', ' <Plug>(coc-codeaction-selected)')
		vim.keymap.set('n', '<leader>a', ' <Plug>(coc-codeaction-selected)')
		vim.keymap.set('n', '<leader>ac', ' <Plug>(coc-codeaction)')
		vim.keymap.set('n', '<leader>qf', ' <Plug>(coc-fix-current)')
		vim.keymap.set('n', '<leader>cl', ' <Plug>(coc-codelens-action)')

		-- Coc hover highlighting
		vim.api.nvim_create_augroup('CocGroup', {})
		vim.api.nvim_create_autocmd('CursorHold', {
			group = 'CocGroup',
			command = "silent call CocActionAsync('highlight')",
			desc = 'Highlight symbol under cursor on CursorHold',
		})

		-- Coc floating window mappings
		vim.keymap.set('n', 'K', ':call CocActionAsync("doHover")<CR>', { silent = true })
		vim.keymap.set('v', 'K', ':<C-U>call CocActionAsync("doHover")<CR>', { silent = true })
		vim.keymap.set({ 'n', 'v' }, '<C-j>', 'coc#float#has_scroll() ? coc#float#scroll(1) : "\\<C-j>"',
			{ silent = true, nowait = true, expr = true })
		vim.keymap.set('i', '<C-j>', 'coc#float#has_scroll() ? "\\<c-r>=coc#float#scroll(1)\\<cr>" : "\\<C-j>"',
			{ silent = true, nowait = true, expr = true })
		vim.keymap.set({ 'n', 'v' }, '<C-k>', 'coc#float#has_scroll() ? coc#float#scroll(0) : "\\<C-k>"',
			{ silent = true, nowait = true, expr = true })
		vim.keymap.set('i', '<C-k>', 'coc#float#has_scroll() ? "\\<c-r>=coc#float#scroll(0)\\<cr>" : "\\<C-k>"',
			{ silent = true, nowait = true, expr = true })

		-- Coc Autocomplete mappings
		local function previous_char_is_whitespace()
			local col = vim.fn.col('.') - 1
			return col == 0 or vim.fn.getline('.'):sub(col, col):match('%s')
		end
		local function replace_termcodes(str)
			return vim.api.nvim_replace_termcodes(str, true, false, true)
		end
		local function do_snippet_jump()
			return replace_termcodes("<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])<CR>")
		end
		function _G.tab()
			if vim.fn['coc#pum#visible']() == 1 then
				return vim.fn['coc#pum#next'](1)
			elseif vim.fn.pumvisible() == 1 then
				return replace_termcodes('<C-n>')
			elseif vim.fn['coc#jumpable']() then
				return do_snippet_jump()
			elseif previous_char_is_whitespace() then
				return replace_termcodes('<Tab>')
			else
				return vim.fn['coc#refresh']()
			end
		end

		function _G.shift_tab()
			if vim.fn['coc#pum#visible']() == 1 then
				return vim.fn['coc#pum#prev'](1)
			elseif vim.fn.pumvisible() == 1 then
				return replace_termcodes('<C-p>')
				-- TODO add support for coc#jumpable
			else
				return replace_termcodes('<C-h>')
			end
		end

		function _G.enter()
			if vim.fn['coc#pum#visible']() == 1 then
				return vim.fn['coc#_select_confirm']()
			elseif vim.fn.pumvisible() == 1 then
				return replace_termcodes('<C-y>')
			elseif vim.fn['coc#expandableOrJumpable']() == 1 then
				return do_snippet_jump()
			else
				return replace_termcodes('<C-g>u<CR><c-r>=coc#on_enter()<CR>')
			end
		end

		function _G.ctrl_space()
			if vim.fn['coc#pum#visible']() == 1 then
				return vim.fn['coc#pum#cancel']()
			else
				return vim.fn['coc#refresh']()
			end
		end

		vim.keymap.set('i', '<TAB>', 'v:lua.tab()', { silent = true, expr = true })
		vim.keymap.set('i', '<S-TAB>', 'v:lua.shift_tab()', { silent = true, expr = true })
		vim.keymap.set('i', '<C-Space>', 'v:lua.ctrl_space()', { silent = true, expr = true })
		vim.keymap.set('i', '<CR>', 'v:lua.enter()', { silent = true, expr = true })
	end
}
