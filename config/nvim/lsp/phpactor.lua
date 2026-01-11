return {
	cmd = { "phpactor", "language-server" },
	filetypes = { "php" },
	init_options = {
		-- Disable Diagnostics
		["language_server.diagnostics_on_update"] = false,
		["language_server.diagnostics_on_open"] = false,
		["language_server.diagnostics_on_save"] = false,
		["language_server.diagnostic_outsource"] = false,

		-- Disable Completion (Intelephense handles this)
		["completion_worse.enabled"] = false,

		-- Disable Hover (Avoid double popups)
		["language_server.hover_label"] = false,

		-- Keep Refactoring features enabled (Phpactor's strength)
		["code_transform.enabled"] = true,
	},
	-- Use client-side filtering to ensure Intelephense wins on overlaps
	on_attach = function(client, bufnr)
		-- Remove capabilities that Intelephense handles better
		client.server_capabilities.completionProvider = false
		client.server_capabilities.hoverProvider = false
		client.server_capabilities.definitionProvider = false
		client.server_capabilities.documentSymbolProvider = false
	end,
}
