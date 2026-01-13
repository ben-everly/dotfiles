local function force_wrap()
	if vim.bo.filetype == "NeogitStatus" then
		vim.opt_local.wrap = true
		vim.opt_local.linebreak = true
	end
end

-- Apply immediately
force_wrap()

-- Force it whenever Neogit says it's done refreshing
vim.api.nvim_create_autocmd("User", {
	pattern = "NeogitStatusRefreshed",
	callback = force_wrap,
})
