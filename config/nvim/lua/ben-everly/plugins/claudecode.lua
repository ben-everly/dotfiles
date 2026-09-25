-- Panes are spawned by the wezterm mux, not neovim, so the IDE env vars are
-- passed explicitly through `env`.
local function wezterm_provider()
	local pane_id = nil

	local function is_alive()
		if not pane_id then
			return false
		end
		local ok, panes = pcall(vim.json.decode, vim.fn.system({ "wezterm", "cli", "list", "--format", "json" }))
		if ok and type(panes) == "table" then
			for _, pane in ipairs(panes) do
				if tostring(pane.pane_id) == pane_id then
					return true
				end
			end
		end
		pane_id = nil
		return false
	end

	local function activate()
		vim.fn.system({ "wezterm", "cli", "activate-pane", "--pane-id", pane_id })
	end

	local provider = {}

	function provider.setup() end

	function provider.open(cmd_string, env_table, effective_config, focus)
		if is_alive() then
			if focus ~= false then
				activate()
			end
			return
		end

		local cmd = {
			"wezterm",
			"cli",
			"split-pane",
			effective_config.split_side == "left" and "--left" or "--right",
			"--percent",
			tostring(math.floor(effective_config.split_width_percentage * 100)),
			"--cwd",
			vim.fn.getcwd(),
			"--",
			"env",
		}
		for key, value in pairs(env_table) do
			table.insert(cmd, key .. "=" .. value)
		end
		vim.list_extend(cmd, require("claudecode.utils").parse_command(cmd_string))

		local out = vim.fn.system(cmd)
		if vim.v.shell_error ~= 0 then
			vim.notify("wezterm split-pane failed: " .. out, vim.log.levels.ERROR)
			return
		end
		pane_id = vim.trim(out)

		if focus == false then
			vim.fn.system({ "wezterm", "cli", "activate-pane", "--pane-id", vim.env.WEZTERM_PANE })
		end
	end

	function provider.close()
		if is_alive() then
			vim.fn.system({ "wezterm", "cli", "kill-pane", "--pane-id", pane_id })
		end
		pane_id = nil
	end

	-- wezterm panes can't be hidden, so toggling focuses instead.
	function provider.simple_toggle(cmd_string, env_table, effective_config)
		provider.open(cmd_string, env_table, effective_config, true)
	end

	provider.focus_toggle = provider.simple_toggle

	function provider.get_active_bufnr()
		return nil
	end

	function provider.is_available()
		return vim.env.WEZTERM_PANE ~= nil and vim.fn.executable("wezterm") == 1
	end

	return provider
end

return {
	"coder/claudecode.nvim",
	config = function()
		require("claudecode").setup({
			---@diagnostic disable-next-line: missing-fields
			terminal = {
				provider = vim.env.WEZTERM_PANE and wezterm_provider() or "native",
				split_width_percentage = 0.4,
			},
		})

		vim.keymap.set("n", "<leader>ac", "<cmd>ClaudeCode<cr>", { desc = "Open Claude" })
		vim.keymap.set("n", "<leader>af", "<cmd>ClaudeCodeFocus<cr>", { desc = "Focus Claude" })
		vim.keymap.set("n", "<leader>ar", "<cmd>ClaudeCode --resume<cr>", { desc = "Resume Claude" })
		vim.keymap.set("n", "<leader>aC", "<cmd>ClaudeCode --continue<cr>", { desc = "Continue Claude" })
		vim.keymap.set("n", "<leader>am", "<cmd>ClaudeCodeSelectModel<cr>", { desc = "Select model" })
		vim.keymap.set("n", "<leader>ab", "<cmd>ClaudeCodeAdd %<cr>", { desc = "Add buffer" })
		vim.keymap.set("v", "<leader>as", "<cmd>ClaudeCodeSend<cr>", { desc = "Send selection" })
		vim.keymap.set("n", "<leader>aa", "<cmd>ClaudeCodeDiffAccept<cr>", { desc = "Accept diff" })
		vim.keymap.set("n", "<leader>ad", "<cmd>ClaudeCodeDiffDeny<cr>", { desc = "Deny diff" })
	end,
}
