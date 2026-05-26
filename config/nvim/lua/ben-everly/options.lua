vim.g.vimsyn_embed = "l"
vim.opt.shortmess:append("c")
vim.opt.signcolumn = "auto:1-9"
vim.opt.sidescrolloff = 2
vim.opt.scrolloff = 3
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.lazyredraw = true
vim.opt.autoread = true
vim.opt.startofline = false
vim.opt.cursorline = true
vim.opt.ignorecase = true
vim.opt.shell = "zsh"
vim.opt.wrap = false
vim.opt.list = true
vim.opt.listchars = {
	tab = "  ",
	trail = "·",
	eol = "↵",
	extends = ">",
	precedes = "<",
}
vim.opt.cmdheight = 1
vim.opt.showmode = false
vim.opt.updatetime = 300
vim.opt.inccommand = "nosplit"
vim.opt.tabstop = 4
vim.opt.autowriteall = true

local yank_to_clipboard_group = vim.api.nvim_create_augroup("yank_to_clipboard", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
	group = yank_to_clipboard_group,
	callback = function()
		if vim.v.event.operator == "y" and vim.v.event.regname == "" then
			vim.fn.setreg("+", vim.v.event.regcontents, vim.v.event.regtype)
		end
	end,
})

vim.cmd.colorscheme("gruvbox-material")

local autowrite_group = vim.api.nvim_create_augroup("autowrite", { clear = true })
vim.api.nvim_create_autocmd("FocusLost", {
	pattern = "*",
	group = autowrite_group,
	command = "silent! wa",
})

local octo_no_swap_group = vim.api.nvim_create_augroup("octo_no_swap", { clear = true })
vim.api.nvim_create_autocmd({ "BufNewFile", "BufReadPre" }, {
	pattern = { "octo://*", "*/octo/null" },
	group = octo_no_swap_group,
	callback = function()
		vim.opt_local.swapfile = false
	end,
})
