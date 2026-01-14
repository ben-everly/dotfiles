return {
	cmd = { "intelephense", "--stdio" },
	filetypes = { "php" },
	settings = {
		intelephense = {
			inlayHints = {
				parameterNames = { enabled = true },
				variableTypes = { enabled = true },
			},
		},
	},
	on_attach = function(client, bufnr)
		-- Disable Rename: Let Phpactor handle complex class/namespace renames
		client.server_capabilities.renameProvider = false
		-- Disable Code Actions: Let Phpactor handle refactoring actions
		client.server_capabilities.codeActionProvider = false

		if client.server_capabilities.inlayHintProvider then
			vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
		end
	end,
}
