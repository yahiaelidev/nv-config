local autocmd = vim.api.nvim_create_autocmd
local ucmd = vim.api.nvim_create_user_command

-- Hell YEaH
ucmd("Q", "q", { nargs = 0 })
ucmd("W", "wa", { nargs = 0 })
ucmd("Wa", "wa", { nargs = 0 })
ucmd("WA", "wa", { nargs = 0 })
ucmd("Wq", "wq", { nargs = 0 })
ucmd("WQ", "wq", { nargs = 0 })
ucmd("Cdd", "lcd %:p:h", { nargs = 0 })

function Autogroup(name, options)
	options = options or {}
	options.clear = options.clear ~= false
	return vim.api.nvim_create_augroup(name, options)
end

autocmd("TextYankPost", {
	group = Autogroup("hightlight-yank"),
	callback = function()
		vim.hl.on_yank()
	end,
})

vim.api.nvim_create_autocmd({ "BufWinEnter", "BufWinLeave" }, {
	group = Autogroup("RememberFolds", { clear = true }),
	pattern = "*",
	callback = function(ev)
		if vim.bo.buftype ~= "" then
			return
		end
		if ev.event == "BufWinEnter" then
			vim.cmd("silent! loadview")
		else
			vim.cmd("silent! mkview")
		end
	end,
})

autocmd("BufWritePost", {
	command = "source %",
	group = Autogroup("ConfigReload"),
	pattern = vim.fn.stdpath("config") .. "/lua/**/*.lua",
	desc = "Automatically reload lua config files on save",
})

autocmd("TermOpen", {
	group = Autogroup("Terminal"),
	callback = function()
		vim.opt.number = false
		vim.opt.relativenumber = false
	end,
})

vim.keymap.set("n", "<space>nr", function()
	local current_file = vim.api.nvim_buf_get_name(0)
	if current_file == "" then
		print("No file is open")
		return
	end

	if not (current_file:match("%.c$") or current_file:match("%.h$")) then
		print("Not a C file (.c or .h)")
		return
	end

	vim.cmd("write!")
	local output_buf = vim.fn.bufnr("Norminette_Output", true)
	vim.cmd("botright 08split | buffer " .. output_buf)

	vim.bo[output_buf].buftype = "nofile"
	vim.bo[output_buf].bufhidden = "wipe"
	vim.bo[output_buf].swapfile = false
	vim.bo[output_buf].filetype = "norminette"
	vim.bo[output_buf].modifiable = true

	vim.api.nvim_buf_set_lines(output_buf, 0, -1, false, {})

	vim.api.nvim_buf_set_lines(output_buf, 0, 0, false, {
		"Norminette results for: " .. current_file,
		"----------------------------------------",
	})

	local cmd = "norminette " .. vim.fn.shellescape(current_file)
	local handle = io.popen(cmd)
	if handle then
		local result = {}
		for line in handle:lines() do
			table.insert(result, line)
		end
		handle:close()
		vim.api.nvim_buf_set_lines(output_buf, 2, -1, false, result)
	else
		vim.api.nvim_buf_set_lines(output_buf, 2, -1, false, { "Failed to run norminette" })
	end

	vim.bo[output_buf].modifiable = false

	vim.api.nvim_buf_set_keymap(output_buf, "n", "q", "<cmd>close<CR>", { nowait = true, silent = true })
	vim.api.nvim_buf_set_keymap(output_buf, "n", "<ESC>", "<cmd>close<CR>", { nowait = true, silent = true })

	if vim.api.nvim_buf_line_count(output_buf) <= 2 then
		vim.cmd("close")
	end
end)
