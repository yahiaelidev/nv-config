local autocmd = vim.api.nvim_create_autocmd

function Autogroup(name, options)
	options = options or {}
	options.clear = options.clear ~= false
	return vim.api.nvim_create_augroup(name, options)
end

local customIndent = Autogroup("Custom-indent")

autocmd("TextYankPost", {
	group = Autogroup("hightlight-yank"),
	callback = function()
		vim.hl.on_yank()
	end,
})

autocmd("BufWritePost", {
	command = "source %",
	group = Autogroup("ConfigReload"),
	pattern = vim.fn.stdpath("config") .. "/lua/**/*.lua",
	desc = "Automatically reload lua config files on save",
})

autocmd("FileType", {
	pattern = { "c" },
	group = customIndent,
	callback = function()
		-- vim.opt.tabstop = 4
		-- vim.bo.cindent = true
		-- vim.opt.shiftwidth = 4
		-- vim.opt.softtabstop = 4
		vim.opt_local.cindent = true
		vim.opt_local.smartindent = true
	end,
})

autocmd("FileType", {
	pattern = { "lua" },
	group = customIndent,
	callback = function()
		vim.opt.tabstop = 2
		vim.opt.shiftwidth = 2
		vim.opt.softtabstop = 2
	end,
})

autocmd("LspAttach", {
	callback = function(args)
		local client = vim.lsp.get_client_by_id(args.data.client_id)
		if not client then
			return
		end
		if vim.bo.filetype == "lua" then
			autocmd("BufWritePre", {
				buffer = args.buf,
				callback = function()
					vim.lsp.buf.format({ bufnr = args.buf, id = client.id })
				end,
			})
		end
	end,
})

autocmd("TermOpen", {
	group = Autogroup("open-Terminal"),
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
