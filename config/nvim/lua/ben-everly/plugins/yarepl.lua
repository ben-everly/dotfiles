local function sail_up(root)
	local res = vim.system({ "docker", "compose", "ps", "--status", "running", "--quiet" }, { cwd = root, text = true })
		:wait(3000)
	return res.code == 0 and res.stdout ~= ""
end

local function php_cmd()
	local root = vim.fs.root(0, { "artisan", "composer.json" })
	if not root then
		return { "php", "-a" }
	end
	if vim.uv.fs_stat(root .. "/vendor/bin/sail") then
		if sail_up(root) then
			-- yarepl can't set a job cwd, and sail resolves .env and compose files from it.
			return { "env", "-C", root, "./vendor/bin/sail", "artisan", "tinker" }
		end
		vim.notify("Sail is down, falling back to local php", vim.log.levels.WARN)
	end
	if vim.uv.fs_stat(root .. "/artisan") then
		return { "php", root .. "/artisan", "tinker" }
	end
	return { "php", "-a" }
end

local ft_to_meta = {
	php = "php",
	python = "python",
	sh = "bash",
	zsh = "zsh",
}

-- Starts the filetype's REPL on first send so <c-c><c-c> works without a manual start.
local function ensure_repl()
	if require("yarepl").bufnr_is_attached_to_repl(vim.api.nvim_get_current_buf()) then
		return true
	end
	local meta = ft_to_meta[vim.bo.filetype]
	if not meta then
		vim.notify("No REPL configured for filetype " .. vim.bo.filetype, vim.log.levels.WARN)
		return false
	end
	local win = vim.api.nvim_get_current_win()
	vim.cmd("Yarepl! start " .. meta)
	vim.api.nvim_set_current_win(win)
	return true
end

return {
	"milanglacier/yarepl.nvim",
	cmd = "Yarepl",
	keys = {
		{
			"<c-c><c-c>",
			function()
				if ensure_repl() then
					vim.api.nvim_feedkeys(vim.keycode("<Plug>(yarepl-send-operator)ip"), "m", false)
				end
			end,
			desc = "Send paragraph to REPL",
		},
		{
			"<c-c><c-c>",
			function()
				-- Sets the '< '> marks before ensure_repl may switch windows.
				vim.cmd("normal! \27")
				if ensure_repl() then
					vim.cmd("Yarepl send_visual")
				end
			end,
			mode = "x",
			desc = "Send selection to REPL",
		},
		{ "<leader>rt", "<Plug>(yarepl-start-or-focus-or-hide)", desc = "Toggle REPL" },
		{ "<leader>rl", "<Plug>(yarepl-send-line)", desc = "Send line to REPL" },
		{ "<leader>rs", "<Plug>(yarepl-send-operator)", desc = "Send motion to REPL" },
		{ "<leader>ra", "<cmd>Yarepl attach_buffer<cr>", desc = "Attach buffer to REPL" },
		{ "<leader>rq", "<Plug>(yarepl-close)", desc = "Close REPL" },
	},
	config = function()
		require("yarepl").setup({
			wincmd = function(bufnr)
				vim.api.nvim_open_win(
					bufnr,
					true,
					{ split = "right", win = -1, width = math.floor(vim.o.columns * 0.5) }
				)
			end,
			metas = {
				php = { cmd = php_cmd, formatter = "trim_empty_lines" },
			},
		})
	end,
}
