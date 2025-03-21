-- Unimplemented features:

-- Coc hover highlighting
-- vim.api.nvim_create_augroup('CocGroup', {})
--[[ vim.api.nvim_create_autocmd('CursorHold', {
			group = 'CocGroup',
			command = "silent call CocActionAsync('highlight')",
			desc = 'Highlight symbol under cursor on CursorHold',
}) ]]

return {
	'neovim/nvim-lspconfig',
	config = function()
		vim.lsp.handlers["textDocument/hover"] =
		vim.lsp.with(
			vim.lsp.handlers.hover,
			{
				border = "single"
			}
		)
		vim.lsp.handlers["textDocument/signatureHelp"] =
		vim.lsp.with(
			vim.lsp.handlers.signature_help,
			{
				border = "single"
			}
		)

		vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float)
		vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist)
		local signs = {
			Error = "󰀩",
			Warn = "",
			Hint = "󱧡",
			Info = "󰭺"
		}
		for type, icon in pairs(signs) do
			local hl = "DiagnosticSign" .. type
			vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
		end
		vim.diagnostic.config({
			virtual_text = {
				spacing = 2,
				prefix = "",
			},
			severity_sort = true,
			float = {
				source = true,
				float = "if_many",
				border = "single"
			},
		})
		local function is_null_ls_formatting_enabled()
			if vim.lsp.get_clients({ name = 'null-ls' }) == nil then
				return false
			end
			local null_ls = require('null-ls')
			for _, formatter in pairs(null_ls.get_source { method = null_ls.methods.FORMATTING}) do
				if formatter.filetypes[vim.bo.filetype] then
					return true
				end
			end
			return false
		end
		vim.api.nvim_create_autocmd('LspAttach', {
			group = vim.api.nvim_create_augroup('UserLspConfig', {}),
			callback = function(ev)
				vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

				local opts = { buffer = ev.buf }
				vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
				vim.keymap.set('n', '<c-k>', vim.lsp.buf.signature_help, opts)
				vim.keymap.set('n', '<leader>Wa', vim.lsp.buf.add_workspace_folder, opts)
				vim.keymap.set('n', '<leader>Wr', vim.lsp.buf.remove_workspace_folder, opts)
				vim.keymap.set('n', '<leader>Wl', function()
					print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
				end, opts)
				vim.keymap.set('n', '<c-f>', function()
					vim.lsp.buf.format {
						async = true,
						filter = function(client)
							if is_null_ls_formatting_enabled() then
								return client.name == 'null-ls'
							end
							return true
						end
					}
				end, opts)
				vim.keymap.set('v', '<c-f>', function()
					vim.lsp.buf.format {
						async = true,
						filter = function(client)
							if is_null_ls_formatting_enabled() then
								return client.name == 'null-ls'
							end
							return true
						end
					}
				end)
			end,
		})
	end,
}
