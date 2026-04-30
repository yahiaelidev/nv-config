local M = {}

M.config = {
	command = "norminette --no-color ",
	extra_args = "-R CheckDefine ",
}

local get_fidget = function()
	return pcall(require, "fidget")
end

local parse_output = function(stdout, default_file)
	local items = {}

	for line in stdout:gmatch("[^\r\n]+") do
		local file, lnum, col, msg = line:match("([^:]+):%s*line:%s*(%d+),%s*col:%s*(%d+)%):%s*(.*)")

		if not file then
			lnum, col, msg = line:match("line:%s*(%d+),%s*col:%s*(%d+)%):%s*(.*)")
			file = default_file
		end
		if lnum and col and msg then
			table.insert(items, {
				filename = default_file,
				lnum = tonumber(lnum),
				col = tonumber(col),
				text = msg,
				type = "E"
			})
		end
	end
	return items
end

local ui_update = function(qf_items)
	local curr_win = vim.api.nvim_get_current_win()
	local has_fidget, fidget = get_fidget()

	if #qf_items == 0 then
		vim.fn.setqflist({}, "r")
		vim.cmd("silent! cclose")

		if has_fidget then
			fidget.progress.handle.create({
				title = "Norminette",
				lsp_client = { name = "OK!" },
			}):finish()
		else
			vim.cmd("redraw")
			print("Norminette: OK!")
		end
	else
		vim.fn.setqflist({}, " ", {
			title = "Norminette",
			items = qf_items,
		})

		vim.cmd("botright silent! cwindow")
		vim.api.nvim_set_current_win(curr_win)

		vim.cmd("redraw")
	end
end

M.run = function()
	local current_file = vim.api.nvim_buf_get_name(0)
	local is_c_file = current_file:match("%.c$")
	local is_h_file = current_file:match("%.h$")

	if current_file == "" or not (is_c_file or is_h_file) then return end

	if vim.bo.modified then vim.cmd("silent! write") end

	local cmd = is_c_file and M.config.command or M.config.command .. M.config.extra_args
	local stdout = vim.fn.system(cmd .. vim.fn.shellescape(current_file))

	if not stdout and vim.v.shell_error ~= 0 then return end

	ui_update(parse_output(stdout, current_file))
end

M.setup = function(opts)
	M.config = vim.tbl_deep_extend("force", M.config, opts or {})

	local group = vim.api.nvim_create_augroup("NorminetteAutoUpdate", { clear = true })
	vim.api.nvim_create_autocmd("BufWritePost", {
		group = group,
		pattern = { "*.c", "*.h" },
		callback = function()
			local wins = vim.api.nvim_list_wins()

			for _, win in ipairs(wins) do
				local buf = vim.api.nvim_win_get_buf(win)

				if vim.bo[buf].buftype == "quickfix" then
					local qf = vim.fn.getqflist({
						winid = win,
						title = 0
					})

					if qf.title and qf.title == "Norminette" then
						vim.schedule(M.run)
						break
					end
				end
			end
		end
	})
end

-- M.run_project_wide = function()
-- 	local has_fidget, fidget = get_fidget()
-- 	local handle = nil
--
-- 	if has_fidget then
-- 		handle = fidget.progress.handle.create({ title = "Norminette", message = "Checking ..." })
-- 	end
--
-- 	local git_root = vim.fn.systemlist("git rev-parse --show-toplevel")[1]
-- 	if vim.v.shell_error ~= 0 then
-- 		print("Not a git repository")
-- 		return
-- 	end
-- end

return M
