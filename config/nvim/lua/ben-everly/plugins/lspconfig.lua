return {
	"neovim/nvim-lspconfig",
	dependencies = { "saghen/blink.cmp" },
	config = function()
		vim.lsp.config("*", {
			capabilities = require("blink.cmp").get_lsp_capabilities(),
		})
	end,
	init = function()
		vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Diagnostics: show line" })
		vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Diagnostics: to loclist" })
		vim.diagnostic.config({
			virtual_text = { spacing = 2, prefix = "" },
			severity_sort = true,
			jump = { float = true },
			float = { source = true, border = "single" },
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

				local function opts(desc)
					return { buffer = ev.buf, desc = desc }
				end
				vim.keymap.set("n", "K", function()
					vim.lsp.buf.hover({ border = "single" })
				end, opts("LSP: hover"))
				vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts("LSP: go to declaration"))
				vim.keymap.set({ "n", "v", "i" }, "<c-s>", function()
					vim.lsp.buf.signature_help({ border = "rounded" })
				end, opts("LSP: signature help"))
				vim.keymap.set("n", "<leader>Wa", vim.lsp.buf.add_workspace_folder, opts("LSP: add workspace folder"))
				vim.keymap.set(
					"n",
					"<leader>Wr",
					vim.lsp.buf.remove_workspace_folder,
					opts("LSP: remove workspace folder")
				)
				vim.keymap.set("n", "<leader>Wl", function()
					vim.print(vim.lsp.buf.list_workspace_folders())
				end, opts("LSP: list workspace folders"))
				vim.keymap.set("n", "<leader>cl", function()
					vim.lsp.codelens.enable(true)
				end, opts("LSP: enable codelens"))
				vim.keymap.set("n", "<leader>cx", vim.lsp.codelens.run, opts("LSP: run codelens"))
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
