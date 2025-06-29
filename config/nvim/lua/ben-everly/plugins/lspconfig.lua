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
		local augroup = vim.api.nvim_create_augroup('UserLspConfig', {})
		vim.api.nvim_create_autocmd('LspAttach', {
			group = augroup,
			callback = function(ev)
				vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

				for _, client in pairs(vim.lsp.get_clients({ bufnr = 0 })) do
					if client.server_capabilities.documentHighlightProvider then
						local lsp_document_highlight = vim.api.nvim_create_augroup('LspDocumentHighlight', {})
						vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
							group = lsp_document_highlight,
							buffer = ev.buf,
							callback = function()
								vim.lsp.buf.document_highlight()
							end,
						})
						vim.api.nvim_create_autocmd('CursorMoved', {
							group = lsp_document_highlight,
							buffer = ev.buf,
							callback = function()
								vim.lsp.buf.clear_references()
							end,
						})
					end
				end

				local opts = { buffer = ev.buf }
				vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
				vim.keymap.set({ 'n', 'v', 'i' }, '<c-k>', function()
					vim.lsp.buf.signature_help({ border = 'rounded' })
				end, opts)
				vim.keymap.set('n', '<leader>Wa', vim.lsp.buf.add_workspace_folder, opts)
				vim.keymap.set('n', '<leader>Wr', vim.lsp.buf.remove_workspace_folder, opts)
				vim.keymap.set('n', '<leader>Wl', function()
					vim.print(vim.lsp.buf.list_workspace_folders())
				end, opts)

				local function is_null_ls_formatting_enabled()
					if vim.lsp.get_clients({ name = 'null-ls' }) == nil then
						return false
					end
					local null_ls = require('null-ls')
					for _, formatter in pairs(null_ls.get_source { method = null_ls.methods.FORMATTING }) do
						if formatter.filetypes[vim.bo.filetype] then
							return true
						end
					end
					return false
				end
				local function format(async)
					if async == nil then
						async = true
					end
					vim.lsp.buf.format {
						async = async,
						filter = function(client)
							if is_null_ls_formatting_enabled() then
								return client.name == 'null-ls'
							end
							return true
						end
					}
				end
				vim.keymap.set('n', '<c-f>', format, opts)
				vim.keymap.set('v', '<c-f>', format, opts)

				vim.api.nvim_create_autocmd('BufWritePre', {
					group = augroup,
					buffer = ev.buf,
					callback = function ()
						format(false)
					end,
				})
			end,
		})
	end,
}
