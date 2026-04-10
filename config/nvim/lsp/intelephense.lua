return {
	settings = {
		intelephense = {
			files = {
				maxSize = 500000,
				exclude = {
					"**/.git/**",
					"**/.svn/**",
					"**/.hg/**",
					"**/CVS/**",
					"**/.DS_Store/**",
					"**/node_modules/**",
					"**/bower_components/**",
					"**/.history/**",
					"**/vendor/**/{Tests,tests}/**",
					"**/vendor/**/vendor/**",
					"**/storage/**",
				},
			},
			inlayHints = {
				parameterNames = { enabled = true },
				variableTypes = { enabled = true },
			},
			codeLens = {
				usages = { enable = true },
				overrides = { enable = true },
				parent = { enable = true },
				references = { enable = true },
				implementations = { enable = true },
			},
			client = {
				codeLensProvider = "pest",
			},
		},
	},
	on_attach = function(client, bufnr)
		-- disable features that are better handled by phpactor
		client.server_capabilities.renameProvider = false
		client.server_capabilities.codeActionProvider = false
	end,
}
