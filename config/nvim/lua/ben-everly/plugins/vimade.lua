-- matches inactive_pane_hsb in config/wezterm/wezterm.lua
local SATURATION = 0.8
local BRIGHTNESS = 0.7
local KEY = "hsb" .. SATURATION .. "," .. BRIGHTNESS

local function to_linear(c)
	c = c / 255
	return c <= 0.04045 and c / 12.92 or ((c + 0.055) / 1.055) ^ 2.4
end

local function to_srgb(c)
	c = c <= 0.0031308 and c * 12.92 or 1.055 * c ^ (1 / 2.4) - 0.055
	return math.floor(math.max(0, math.min(1, c)) * 255 + 0.5)
end

-- wezterm scales HSV in linear light; with hue fixed that reduces to a per-channel blend toward max
local function scale(c, max)
	return to_srgb(BRIGHTNESS * (max + SATURATION * (c - max)))
end

local function transform(color)
	local r = to_linear(bit.rshift(color, 16))
	local g = to_linear(bit.band(bit.rshift(color, 8), 0xff))
	local b = to_linear(bit.band(color, 0xff))
	local max = math.max(r, g, b)
	return bit.bor(bit.lshift(scale(r, max), 16), bit.lshift(scale(g, max), 8), scale(b, max))
end

local hsb_style = {
	attach = function(win)
		local condition = require("vimade.style.value.condition").INACTIVE
		local active
		local style = { win = win }
		style.before = function(_, state)
			active = condition(style, state)
		end
		style.key = function()
			return active and KEY or ""
		end
		style.modify = function(highlights)
			if not active then
				return
			end
			for _, hl in pairs(highlights) do
				if not hl.link then
					hl.fg = hl.fg and transform(hl.fg)
					hl.sp = hl.sp and transform(hl.sp)
				end
			end
		end
		return style
	end,
}

return {
	"TaDaa/vimade",
	config = function()
		require("vimade").setup({
			ncmode = "windows",
			style = { hsb_style },
			blocklist = {
				undimmed = { highlights = { "/WinSeparator/", "/VertSplit/", "/Neogit/" } },
			},
		})
	end,
}
