return {
	"neovim/nvim-lspconfig",
	config = function() end,
	init = function()
		vim.lsp.config["cssls"] = {
			settings = {
				css = {
					lint = {
						unknownAtRules = "ignore",
					},
				},
			},
		}

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
		vim.api.nvim_create_autocmd({ "LspAttach", "LspDetach" }, {
			group = augroup,
			callback = function(ev)
				vim.api.nvim_clear_autocmds({ group = augroup, buffer = ev.buf })
				vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

				for _, client in pairs(vim.lsp.get_clients({ bufnr = ev.buf })) do
					if client.server_capabilities.documentHighlightProvider then
						if not ev.event == "LspDetach" or not ev.data.client_id == client.id then
							vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
								group = augroup,
								buffer = ev.buf,
								callback = function()
									vim.lsp.buf.document_highlight()
								end,
							})
						end
						vim.api.nvim_create_autocmd("CursorMoved", {
							group = augroup,
							buffer = ev.buf,
							callback = function()
								vim.lsp.buf.clear_references()
							end,
						})
					end
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
	end,
}
