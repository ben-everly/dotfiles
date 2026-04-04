local function previous_char_is_whitespace()
	local col = vim.fn.col(".") - 1
	return col == 0 or vim.fn.getline("."):sub(col, col):match("%s")
end

return {
	"hrsh7th/nvim-cmp",
	event = "InsertEnter",
	opts = function()
		local cmp = require("cmp")
		return {
			sources = {},
			mapping = cmp.mapping.preset.insert({
				["<C-u>"] = cmp.mapping.scroll_docs(-4),
				["<C-d>"] = cmp.mapping.scroll_docs(4),
				["<CR>"] = cmp.mapping.confirm({ select = false }),
				["<Tab>"] = function(fallback)
					if cmp.visible() then
						cmp.select_next_item()
					elseif not previous_char_is_whitespace() then
						cmp.complete()
					else
						fallback()
					end
				end,
				["<S-Tab>"] = function(fallback)
					if cmp.visible() then
						cmp.select_prev_item()
					elseif not previous_char_is_whitespace() then
						cmp.complete()
					else
						fallback()
					end
				end,
			}),
		}
	end,
}
