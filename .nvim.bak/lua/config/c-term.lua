local M = {}

local Term_job_id = 0

local function find_term_win()
	if Term_job_id > 0 then
		for _, win in ipairs(vim.api.nvim_list_wins()) do
			local chan_id = vim.b[vim.api.nvim_win_get_buf(win)].terminal_job_id
			if chan_id and chan_id == Term_job_id then
				return win
			end
		end
	end
	return -1
end

local function create_term()
	vim.cmd.new()
	vim.cmd.term()
	vim.cmd.wincmd 'V'
	vim.api.nvim_win_set_height(0, 15)
	Term_job_id = vim.b.terminal_job_id
end

local function send_run_command(file_name)
	if file_name == '' then
		vim.notify('Could not find a valid C file.', vim.log.levels.ERROR)
		return
	end

	local file_dir = vim.fn.expand('%:p:h')

	local output_name = 'a.out'
	local command = 'cd ' ..
	file_dir .. ' && rm -f ' .. output_name .. '; ccw ' .. file_name .. ' && ./' .. output_name .. '\n'

	vim.fn.chansend(Term_job_id, command)
	vim.notify('✅ Command sent to terminal.', vim.log.levels.INFO)

	local term_win_id = find_term_win()
	if term_win_id > 0 then
		local term_buf_id = vim.api.nvim_win_get_buf(term_win_id)
		local last_line = vim.api.nvim_buf_line_count(term_buf_id)
		vim.api.nvim_win_set_cursor(term_win_id, { last_line, 0 })
	end
end

-- Keymaps
vim.keymap.set('n', '<space>st', function()
	local term_win_id = find_term_win()
	if term_win_id > 0 then
		vim.api.nvim_set_current_win(term_win_id)
	else
		create_term()
	end
end, { desc = 'Terminal: Open or Focus' })

vim.keymap.set('n', '<space>run', function()
	-- ✨ FIX: Save the file before doing anything else.
	vim.cmd.write()

	local original_win = vim.api.nvim_get_current_win()
	local file_name = vim.fn.expand '%:t'

	if vim.bo.filetype ~= 'c' or file_name == '' then
		vim.notify('Please run this command from a C file.', vim.log.levels.WARN)
		return
	end

	if find_term_win() == -1 then
		create_term()
		vim.api.nvim_set_current_win(original_win)
		vim.defer_fn(function()
			send_run_command(file_name)
		end, 100)
	else
		send_run_command(file_name)
	end
end, { desc = 'Terminal: Compile & Run' })

vim.keymap.set('n', '<space>sc', function()
	local term_win_id = find_term_win()
	if term_win_id > 0 then
		local term_buf_id = vim.api.nvim_win_get_buf(term_win_id)
		vim.fn.jobstop(Term_job_id)
		vim.api.nvim_win_close(term_win_id, true)
		vim.api.nvim_buf_delete(term_buf_id, { force = true })
		Term_job_id = 0
		vim.notify('Terminal closed.', vim.log.levels.INFO)
	else
		vim.notify('Terminal is not running.', vim.log.levels.INFO)
		Term_job_id = 0
	end
end, { desc = 'Terminal: Close' })
return M
