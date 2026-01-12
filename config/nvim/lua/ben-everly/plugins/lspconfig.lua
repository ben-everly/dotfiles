return {
	"neovim/nvim-lspconfig",
	config = function() end,
	init = function()
		vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float)
		vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist)
		vim.diagnostic.config({
			virtual_text = { spacing = 2, prefix = "" },
			severity_sort = true,
			float = { source = true, float = "if_many", border = "single" },
			signs = {
				text = {
					[vim.diagnostic.severity.ERROR] = "󰀩",
					[vim.diagnostic.severity.WARN] = "",
					[vim.diagnostic.severity.INFO] = "󰭺",
					[vim.diagnostic.severity.HINT] = "󱧡",
				},
			},
		})

		local augroup = vim.api.nvim_create_augroup("UserLspConfig", {})

		vim.api.nvim_create_autocmd("LspAttach", {
			group = augroup,
			callback = function(ev)
				local client = vim.lsp.get_client_by_id(ev.data.client_id)
				vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

				if client and client.server_capabilities.documentHighlightProvider then
					vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
						group = augroup,
						buffer = ev.buf,
						callback = vim.lsp.buf.document_highlight,
					})
					vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
						group = augroup,
						buffer = ev.buf,
						callback = vim.lsp.buf.clear_references,
					})
				end

				local opts = { buffer = ev.buf }
				vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
				vim.keymap.set({ "n", "v", "i" }, "<c-k>", function()
					vim.lsp.buf.signature_help({ border = "rounded" })
				end, opts)
				vim.keymap.set("n", "<leader>Wa", vim.lsp.buf.add_workspace_folder, opts)
				vim.keymap.set("n", "<leader>Wr", vim.lsp.buf.remove_workspace_folder, opts)
				vim.keymap.set("n", "<leader>Wl", function()
					vim.print(vim.lsp.buf.list_workspace_folders())
				end, opts)
			end,
		})

		vim.api.nvim_create_autocmd("LspDetach", {
			group = augroup,
			callback = function(ev)
				vim.lsp.buf.clear_references()
				vim.api.nvim_clear_autocmds({ group = augroup, buffer = ev.buf })
			end,
		})
	end,
}
