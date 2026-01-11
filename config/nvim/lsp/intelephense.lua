return {
	cmd = { "intelephense", "--stdio" },
	filetypes = { "php" },
	on_attach = function(client, bufnr)
		-- Disable Rename: Let Phpactor handle complex class/namespace renames
		client.server_capabilities.renameProvider = false
		-- Disable Code Actions: Let Phpactor handle refactoring actions
		client.server_capabilities.codeActionProvider = false
	end,
}
