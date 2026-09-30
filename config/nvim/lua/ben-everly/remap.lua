vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.keymap.set("n", "<C-t>", vim.cmd.enew, { desc = "Buffer: new" })
vim.keymap.set("n", "<C-.>", vim.cmd.bnext, { desc = "Buffer: next" })
vim.keymap.set("n", "<C-,>", vim.cmd.bprevious, { desc = "Buffer: previous" })

local function visual_search(direction)
	local old_reg = vim.fn.getreg('"')
	local old_regtype = vim.fn.getregtype('"')
	vim.cmd("silent normal! y")
	vim.fn.feedkeys(
		direction
			.. vim.fn.substitute(vim.fn.escape(vim.fn.getreg('"'), [[\/.*$^~[]]), [[\_s\+]], [[\\_s\\+]], "g")
			.. "\r"
	)
	vim.fn.setreg('"', old_reg, old_regtype)
end
vim.keymap.set("v", "*", function()
	visual_search("/")
end, { desc = "Search: selection forward" })
vim.keymap.set("v", "#", function()
	visual_search("?")
end, { desc = "Search: selection backward" })

local low = function(i)
	return string.char(97 + i)
end
local upp = function(i)
	return string.char(65 + i)
end

for i = 0, 25 do
	vim.keymap.set("n", "m" .. low(i), "m" .. upp(i), { desc = "Mark: set global " .. upp(i) })
end
for i = 0, 25 do
	vim.keymap.set("n", "m" .. upp(i), "m" .. low(i), { desc = "Mark: set local " .. low(i) })
end
for i = 0, 25 do
	vim.keymap.set("n", "'" .. low(i), "'" .. upp(i), { desc = "Mark: jump to global " .. upp(i) .. " line" })
end
for i = 0, 25 do
	vim.keymap.set("n", "'" .. upp(i), "'" .. low(i), { desc = "Mark: jump to local " .. low(i) .. " line" })
end
for i = 0, 25 do
	vim.keymap.set("n", "`" .. low(i), "`" .. upp(i), { desc = "Mark: jump to global " .. upp(i) })
end
for i = 0, 25 do
	vim.keymap.set("n", "`" .. upp(i), "`" .. low(i), { desc = "Mark: jump to local " .. low(i) })
end
