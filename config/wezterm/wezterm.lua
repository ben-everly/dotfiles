local wezterm = require("wezterm")
local config = wezterm.config_builder()

config.colors = wezterm.color.get_builtin_schemes()["Gruvbox Material (Gogh)"]
config.colors.tab_bar = {
	active_tab = { bg_color = config.colors.background, fg_color = config.colors.foreground },
	inactive_tab = { bg_color = "#383838", fg_color = "#928374" },
	inactive_tab_hover = { bg_color = "#383838", fg_color = config.colors.foreground },
	new_tab = { bg_color = "#383838", fg_color = "#928374" },
	new_tab_hover = { bg_color = "#383838", fg_color = config.colors.foreground },
}

config.window_frame = {
	inactive_titlebar_bg = config.colors.background,
	active_titlebar_bg = config.colors.background,
	inactive_titlebar_fg = config.colors.foreground,
	active_titlebar_fg = config.colors.foreground,
}
config.command_palette_bg_color = config.colors.background
config.command_palette_fg_color = config.colors.foreground
config.char_select_bg_color = config.colors.background
config.char_select_fg_color = config.colors.tab_bar.active_tab.fg_color

config.window_background_opacity = 0.75
config.text_background_opacity = 0.6
config.inactive_pane_hsb = { saturation = 0.8, brightness = 0.7 }

config.font = wezterm.font("OperatorMonoLig")
config.font_size = 13.0
config.window_frame = {
	font = wezterm.font("JetBrainsMonoNerdFont"),
	font_size = 12.0,
	active_titlebar_bg = "#383838",
}
config.adjust_window_size_when_changing_font_size = false

config.default_workspace = "~"
local resurrect = wezterm.plugin.require("https://github.com/MLFlexer/resurrect.wezterm")
resurrect.state_manager.periodic_save({
	interval_seconds = 300,
	save_workspaces = true,
	save_windows = true,
	save_tabs = true,
})

resurrect.state_manager.set_encryption({
	enable = false,
})

wezterm.on("resurrect.error", function(err)
	wezterm.log_error("ERROR!")
	wezterm.gui.gui_windows()[1]:toast_notification("resurrect", err, nil, 3000)
end)

local workspace_switcher = wezterm.plugin.require("https://github.com/MLFlexer/smart_workspace_switcher.wezterm")

workspace_switcher.workspace_formatter = function(label)
	return wezterm.format({
		{ Attribute = { Italic = true } },
		{ Foreground = { Color = config.colors.ansi[3] } },
		{ Background = { Color = config.colors.background } },
		{ Text = "󱂬 : " .. label },
	})
end

local function basename(s)
	return string.gsub(s, "(.*[/\\])(.*)", "%2")
end

wezterm.on("smart_workspace_switcher.workspace_switcher.created", function(window, path, label)
	window:gui_window():set_right_status(wezterm.format({
		{ Attribute = { Intensity = "Bold" } },
		{ Foreground = { Color = config.colors.ansi[5] } },
		{ Text = basename(path) .. "  " },
	}))
	local workspace_state = resurrect.workspace_state

	workspace_state.restore_workspace(resurrect.state_manager.load_state(label, "workspace"), {
		window = window,
		relative = true,
		restore_text = true,

		resize_window = false,
		on_pane_restore = resurrect.tab_state.default_on_pane_restore,
	})
end)

wezterm.on("smart_workspace_switcher.workspace_switcher.chosen", function(window, path, label)
	wezterm.log_info(window)
	window:gui_window():set_right_status(wezterm.format({
		{ Attribute = { Intensity = "Bold" } },
		{ Foreground = { Color = config.colors.ansi[5] } },
		{ Text = basename(path) .. "  " },
	}))
end)

wezterm.on("smart_workspace_switcher.workspace_switcher.selected", function(window, path, label)
	wezterm.log_info(window)
	local workspace_state = resurrect.workspace_state
	resurrect.state_manager.save_state(workspace_state.get_workspace_state())
	resurrect.state_manager.write_current_state(label, "workspace")
end)

wezterm.on("smart_workspace_switcher.workspace_switcher.start", function(window, _)
	wezterm.log_info(window)
end)
wezterm.on("smart_workspace_switcher.workspace_switcher.canceled", function(window, _)
	wezterm.log_info(window)
end)

wezterm.on("gui-startup", resurrect.state_manager.resurrect_on_gui_startup)

config.disable_default_key_bindings = true
local act = wezterm.action
config.keys = {
	{ key = "T", mods = "SHIFT|CTRL", action = act.SpawnTab("CurrentPaneDomain") },
	{
		key = "W",
		mods = "SHIFT|CTRL",
		action = act.CloseCurrentTab({ confirm = true }),
	},
	{ key = "!", mods = "SHIFT|CTRL", action = act.ActivateTab(0) },
	{ key = "@", mods = "SHIFT|CTRL", action = act.ActivateTab(1) },
	{ key = "#", mods = "SHIFT|CTRL", action = act.ActivateTab(2) },
	{ key = "$", mods = "SHIFT|CTRL", action = act.ActivateTab(3) },
	{ key = "%", mods = "SHIFT|CTRL", action = act.ActivateTab(4) },
	{ key = "^", mods = "SHIFT|CTRL", action = act.ActivateTab(5) },
	{ key = "&", mods = "SHIFT|CTRL", action = act.ActivateTab(6) },
	{ key = "*", mods = "SHIFT|CTRL", action = act.ActivateTab(7) },
	{ key = "(", mods = "SHIFT|CTRL", action = act.ActivateTab(8) },
	{ key = "Tab", mods = "CTRL", action = act.ActivateTabRelative(1) },
	{ key = "Tab", mods = "SHIFT|CTRL", action = act.ActivateTabRelative(-1) },
	{ key = "<", mods = "SHIFT|CTRL", action = act.ActivateTabRelative(-1) },
	{ key = ">", mods = "SHIFT|CTRL", action = act.ActivateTabRelative(1) },
	{ key = "LeftArrow", mods = "SHIFT|CTRL", action = act.MoveTabRelative(-1) },
	{ key = "RightArrow", mods = "SHIFT|CTRL", action = act.MoveTabRelative(1) },

	{
		key = '"',
		mods = "SHIFT|ALT|CTRL",
		action = act.SplitVertical({ domain = "CurrentPaneDomain" }),
	},
	{
		key = "%",
		mods = "SHIFT|ALT|CTRL",
		action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }),
	},
	{ key = "H", mods = "SHIFT|CTRL", action = act.ActivatePaneDirection("Left") },
	{ key = "L", mods = "SHIFT|CTRL", action = act.ActivatePaneDirection("Right") },
	{ key = "K", mods = "SHIFT|CTRL", action = act.ActivatePaneDirection("Up") },
	{ key = "J", mods = "SHIFT|CTRL", action = act.ActivatePaneDirection("Down") },
	{
		key = "H",
		mods = "SHIFT|ALT|CTRL",
		action = act.AdjustPaneSize({ "Left", 1 }),
	},
	{
		key = "L",
		mods = "SHIFT|ALT|CTRL",
		action = act.AdjustPaneSize({ "Right", 1 }),
	},
	{ key = "K", mods = "SHIFT|ALT|CTRL", action = act.AdjustPaneSize({ "Up", 1 }) },
	{
		key = "J",
		mods = "SHIFT|ALT|CTRL",
		action = act.AdjustPaneSize({ "Down", 1 }),
	},
	{ key = "O", mods = "SHIFT|CTRL", action = act.RotatePanes("Clockwise") },
	{
		key = "I",
		mods = "SHIFT|CTRL",
		action = act.RotatePanes("CounterClockwise"),
	},
	{ key = "M", mods = "SHIFT|CTRL", action = act.TogglePaneZoomState },

	{ key = "C", mods = "SHIFT|CTRL", action = act.CopyTo("Clipboard") },
	{ key = "V", mods = "SHIFT|CTRL", action = act.PasteFrom("Clipboard") },
	{ key = "X", mods = "SHIFT|CTRL", action = act.ActivateCopyMode },
	{ key = "phys:Space", mods = "SHIFT|CTRL", action = act.QuickSelect },
	{
		key = "F",
		mods = "SHIFT|CTRL",
		action = act.Search("CurrentSelectionOrEmptyString"),
	},
	{ key = "N", mods = "SHIFT|CTRL", action = act.SpawnWindow },
	{ key = "Enter", mods = "SHIFT|CTRL", action = act.ToggleFullScreen },
	{ key = "+", mods = "SHIFT|CTRL", action = act.IncreaseFontSize },
	{ key = "_", mods = "SHIFT|CTRL", action = act.DecreaseFontSize },
	{ key = ")", mods = "SHIFT|CTRL", action = act.ResetFontSize },
	{
		key = "D",
		mods = "SHIFT|CTRL",
		action = act.DetachDomain("CurrentPaneDomain"),
	},
	{ key = "l", mods = "ALT|CTRL", action = act.ShowDebugOverlay },
	{ key = "P", mods = "SHIFT|CTRL", action = act.ActivateCommandPalette },
	{
		key = "U",
		mods = "SHIFT|CTRL",
		action = act.CharSelect({
			copy_on_select = true,
			copy_to = "ClipboardAndPrimarySelection",
		}),
	},
	{ key = "PageUp", mods = "SHIFT", action = act.ScrollByPage(-1) },
	{ key = "PageDown", mods = "SHIFT", action = act.ScrollByPage(1) },
	{
		key = "T",
		mods = "SHIFT|CTRL|ALT",
		action = act.PromptInputLine({
			description = "Enter new name for tab",
			action = wezterm.action_callback(function(window, pane, line)
				if line and #line > 0 then
					window:active_tab():set_title(line)
				end
			end),
		}),
	},
	{
		key = "S",
		mods = "SHIFT|CTRL",
		action = workspace_switcher.switch_workspace(),
	},
	{
		key = "S", -- Or any other key you prefer
		mods = "SHIFT|CTRL|ALT",
		action = wezterm.action.PromptInputLine({
			description = "Enter new workspace name:",
			action = wezterm.action_callback(function(window, pane, line)
				if line then
					wezterm.mux.rename_workspace(wezterm.mux.get_active_workspace(), line)
				end
			end),
		}),
	},
}

config.key_tables = {
	copy_mode = {
		{ key = "Tab", mods = "NONE", action = act.CopyMode("MoveForwardWord") },
		{ key = "Tab", mods = "SHIFT", action = act.CopyMode("MoveBackwardWord") },
		{
			key = "Enter",
			mods = "NONE",
			action = act.CopyMode("MoveToStartOfNextLine"),
		},
		{ key = "Escape", mods = "NONE", action = act.CopyMode("Close") },
		{
			key = "Space",
			mods = "NONE",
			action = act.CopyMode({ SetSelectionMode = "Cell" }),
		},
		{
			key = "$",
			mods = "NONE",
			action = act.CopyMode("MoveToEndOfLineContent"),
		},
		{
			key = "$",
			mods = "SHIFT",
			action = act.CopyMode("MoveToEndOfLineContent"),
		},
		{ key = ",", mods = "NONE", action = act.CopyMode("JumpReverse") },
		{ key = "0", mods = "NONE", action = act.CopyMode("MoveToStartOfLine") },
		{ key = ";", mods = "NONE", action = act.CopyMode("JumpAgain") },
		{
			key = "F",
			mods = "NONE",
			action = act.CopyMode({ JumpBackward = { prev_char = false } }),
		},
		{
			key = "F",
			mods = "SHIFT",
			action = act.CopyMode({ JumpBackward = { prev_char = false } }),
		},
		{
			key = "G",
			mods = "NONE",
			action = act.CopyMode("MoveToScrollbackBottom"),
		},
		{
			key = "G",
			mods = "SHIFT",
			action = act.CopyMode("MoveToScrollbackBottom"),
		},
		{ key = "H", mods = "NONE", action = act.CopyMode("MoveToViewportTop") },
		{ key = "H", mods = "SHIFT", action = act.CopyMode("MoveToViewportTop") },
		{ key = "L", mods = "NONE", action = act.CopyMode("MoveToViewportBottom") },
		{
			key = "L",
			mods = "SHIFT",
			action = act.CopyMode("MoveToViewportBottom"),
		},
		{ key = "M", mods = "NONE", action = act.CopyMode("MoveToViewportMiddle") },
		{
			key = "M",
			mods = "SHIFT",
			action = act.CopyMode("MoveToViewportMiddle"),
		},
		{
			key = "O",
			mods = "NONE",
			action = act.CopyMode("MoveToSelectionOtherEndHoriz"),
		},
		{
			key = "O",
			mods = "SHIFT",
			action = act.CopyMode("MoveToSelectionOtherEndHoriz"),
		},
		{
			key = "T",
			mods = "NONE",
			action = act.CopyMode({ JumpBackward = { prev_char = true } }),
		},
		{
			key = "T",
			mods = "SHIFT",
			action = act.CopyMode({ JumpBackward = { prev_char = true } }),
		},
		{
			key = "V",
			mods = "NONE",
			action = act.CopyMode({ SetSelectionMode = "Line" }),
		},
		{
			key = "V",
			mods = "SHIFT",
			action = act.CopyMode({ SetSelectionMode = "Line" }),
		},
		{
			key = "^",
			mods = "NONE",
			action = act.CopyMode("MoveToStartOfLineContent"),
		},
		{
			key = "^",
			mods = "SHIFT",
			action = act.CopyMode("MoveToStartOfLineContent"),
		},
		{ key = "b", mods = "NONE", action = act.CopyMode("MoveBackwardWord") },
		{ key = "b", mods = "ALT", action = act.CopyMode("MoveBackwardWord") },
		{ key = "b", mods = "CTRL", action = act.CopyMode("PageUp") },
		{ key = "c", mods = "CTRL", action = act.CopyMode("Close") },
		{ key = "d", mods = "CTRL", action = act.CopyMode({ MoveByPage = 0.5 }) },
		{ key = "e", mods = "NONE", action = act.CopyMode("MoveForwardWordEnd") },
		{
			key = "f",
			mods = "NONE",
			action = act.CopyMode({ JumpForward = { prev_char = false } }),
		},
		{ key = "f", mods = "ALT", action = act.CopyMode("MoveForwardWord") },
		{ key = "f", mods = "CTRL", action = act.CopyMode("PageDown") },
		{ key = "g", mods = "NONE", action = act.CopyMode("MoveToScrollbackTop") },
		{ key = "g", mods = "CTRL", action = act.CopyMode("Close") },
		{ key = "h", mods = "NONE", action = act.CopyMode("MoveLeft") },
		{ key = "j", mods = "NONE", action = act.CopyMode("MoveDown") },
		{ key = "k", mods = "NONE", action = act.CopyMode("MoveUp") },
		{ key = "l", mods = "NONE", action = act.CopyMode("MoveRight") },
		{
			key = "m",
			mods = "ALT",
			action = act.CopyMode("MoveToStartOfLineContent"),
		},
		{
			key = "o",
			mods = "NONE",
			action = act.CopyMode("MoveToSelectionOtherEnd"),
		},
		{ key = "q", mods = "NONE", action = act.CopyMode("Close") },
		{
			key = "t",
			mods = "NONE",
			action = act.CopyMode({ JumpForward = { prev_char = true } }),
		},
		{ key = "u", mods = "CTRL", action = act.CopyMode({ MoveByPage = -0.5 }) },
		{
			key = "v",
			mods = "NONE",
			action = act.CopyMode({ SetSelectionMode = "Cell" }),
		},
		{
			key = "v",
			mods = "CTRL",
			action = act.CopyMode({ SetSelectionMode = "Block" }),
		},
		{ key = "w", mods = "NONE", action = act.CopyMode("MoveForwardWord") },
		{
			key = "y",
			mods = "NONE",
			action = act.Multiple({
				{ CopyTo = "ClipboardAndPrimarySelection" },
				{ CopyMode = "Close" },
			}),
		},
		{ key = "PageUp", mods = "NONE", action = act.CopyMode("PageUp") },
		{ key = "PageDown", mods = "NONE", action = act.CopyMode("PageDown") },
		{
			key = "End",
			mods = "NONE",
			action = act.CopyMode("MoveToEndOfLineContent"),
		},
		{ key = "Home", mods = "NONE", action = act.CopyMode("MoveToStartOfLine") },
		{ key = "LeftArrow", mods = "NONE", action = act.CopyMode("MoveLeft") },
		{
			key = "LeftArrow",
			mods = "ALT",
			action = act.CopyMode("MoveBackwardWord"),
		},
		{ key = "RightArrow", mods = "NONE", action = act.CopyMode("MoveRight") },
		{
			key = "RightArrow",
			mods = "ALT",
			action = act.CopyMode("MoveForwardWord"),
		},
		{ key = "UpArrow", mods = "NONE", action = act.CopyMode("MoveUp") },
		{ key = "DownArrow", mods = "NONE", action = act.CopyMode("MoveDown") },
	},

	search_mode = {
		{ key = "Enter", mods = "NONE", action = act.CopyMode("PriorMatch") },
		{ key = "Escape", mods = "NONE", action = act.CopyMode("Close") },
		{ key = "n", mods = "CTRL", action = act.CopyMode("NextMatch") },
		{ key = "p", mods = "CTRL", action = act.CopyMode("PriorMatch") },
		{ key = "r", mods = "CTRL", action = act.CopyMode("CycleMatchType") },
		{ key = "u", mods = "CTRL", action = act.CopyMode("ClearPattern") },
		{ key = "PageUp", mods = "NONE", action = act.CopyMode("PriorMatchPage") },
		{ key = "PageDown", mods = "NONE", action = act.CopyMode("NextMatchPage") },
		{ key = "UpArrow", mods = "NONE", action = act.CopyMode("PriorMatch") },
		{ key = "DownArrow", mods = "NONE", action = act.CopyMode("NextMatch") },
	},
}

return config
