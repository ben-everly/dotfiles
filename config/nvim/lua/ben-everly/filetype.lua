-- lsp configs only attach to these compound filetypes, which nvim never detects on its own
vim.filetype.add({
	filename = {
		["compose.yml"] = "yaml.docker-compose",
		["compose.yaml"] = "yaml.docker-compose",
		["docker-compose.yml"] = "yaml.docker-compose",
		["docker-compose.yaml"] = "yaml.docker-compose",
	},
	pattern = {
		[".*/%.ansible/.*%.ya?ml"] = "yaml.ansible",
		[".*/docker%-compose%..+%.ya?ml"] = "yaml.docker-compose",
		[".*/compose%..+%.ya?ml"] = "yaml.docker-compose",
	},
})
