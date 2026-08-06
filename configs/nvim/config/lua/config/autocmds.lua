vim.api.nvim_create_autocmd('VimEnter', {
	callback = function()
		if vim.fn.argc() == 0 then
			vim.cmd 'Neotree current'
		end
	end,
})

-- [[ Basic Autocommands ]]
vim.api.nvim_create_autocmd('TextYankPost', {
	desc = 'Highlight when yanking (copying) text',
	group = vim.api.nvim_create_augroup('highlight-yank', { clear = true }),
	callback = function()
		vim.hl.on_yank()
	end,
})

vim.api.nvim_create_autocmd({ 'FocusGained', 'BufEnter', 'CursorHold', 'CursorHoldI' }, {
	callback = function()
		if vim.o.buftype ~= '' then
			return
		end
		vim.cmd 'checktime'
	end,
})

vim.api.nvim_create_autocmd('FileChangedShellPost', {
	callback = function()
		vim.notify('File changed on disk. Buffer reloaded.', vim.log.levels.INFO)
	end,
})
