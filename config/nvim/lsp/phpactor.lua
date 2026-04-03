return {
	init_options = {
		-- disable features that are better handled by intelephense
		["language_server.diagnostics_on_update"] = false,
		["language_server.diagnostics_on_open"] = false,
		["language_server.diagnostics_on_save"] = false,
		["language_server.diagnostic_outsource"] = false,
		["completion_worse.enabled"] = false,
		["language_server.hover_label"] = false,
		["code_transform.enabled"] = true,
		["language_server_configuration.auto_config"] = false,
		["indexer.exclude_patterns"] = {
			"/vendor/**/Tests/**/*",
			"/vendor/**/tests/**/*",
			"/vendor/composer/**/*",
			"**/storage/**/*",
			"**/node_modules/**/*",
		},
		["code_transform.refactor.generate_mutator.fluent"] = true,
	},
	on_attach = function(client, _)
		client.server_capabilities.completionProvider = false
		client.server_capabilities.hoverProvider = false
		client.server_capabilities.definitionProvider = false
		client.server_capabilities.referencesProvider = false
		client.server_capabilities.implementationProvider = false
		client.server_capabilities.documentSymbolProvider = false
	end,
}
