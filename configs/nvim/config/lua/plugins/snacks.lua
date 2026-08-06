return {
	{
		'folke/snacks.nvim',
		priority = 1000,
		lazy = false,
		---@type snacks.Config
		opts = {
			bigfile = { enabled = true },
			input = { enabled = true },
			notifier = { enabled = true },
			quickfile = { enabled = true },
			scope = { enabled = true },
			scroll = { enabled = true },
			statuscolumn = { enabled = true },
			terminal = {
				win = {
					position = 'float',
					border = 'rounded',
				},
			},
			words = { enabled = true },
		},
		keys = {
			{ '<leader>z', function() Snacks.zen() end, desc = 'Toggle Zen mode' },
			{ '<leader>Z', function() Snacks.zen.zoom() end, desc = 'Toggle zoom' },
			{ '<leader>.', function() Snacks.scratch() end, desc = 'Toggle scratch buffer' },
			{ '<leader>S', function() Snacks.scratch.select() end, desc = 'Select scratch buffer' },
			{ '<leader>bd', function() Snacks.bufdelete() end, desc = 'Delete buffer' },
			{ '<leader>cR', function() Snacks.rename.rename_file() end, desc = 'Rename file' },
			{ '<leader>gB', function() Snacks.gitbrowse() end, desc = 'Open in browser', mode = { 'n', 'v' } },
			{ '<leader>nh', function() Snacks.notifier.show_history() end, desc = 'Notification history' },
			{ '<leader>nd', function() Snacks.notifier.hide() end, desc = 'Dismiss notifications' },
			{ '<C-/>', function() Snacks.terminal() end, desc = 'Toggle popup terminal' },
			{ '<C-_>', function() Snacks.terminal() end, desc = 'Toggle popup terminal' },
			{ ']]', function() Snacks.words.jump(vim.v.count1) end, desc = 'Next reference', mode = { 'n', 't' } },
			{ '[[', function() Snacks.words.jump(-vim.v.count1) end, desc = 'Previous reference', mode = { 'n', 't' } },
		},
		init = function()
			vim.api.nvim_create_autocmd('User', {
				pattern = 'VeryLazy',
				callback = function()
					Snacks.toggle.option('spell', { name = 'Spelling' }):map '<leader>ts'
					Snacks.toggle.option('wrap', { name = 'Wrap' }):map '<leader>tw'
					Snacks.toggle.diagnostics():map '<leader>td'
					Snacks.toggle.line_number():map '<leader>tl'
					Snacks.toggle.inlay_hints():map '<leader>th'
				end,
			})
		end,
	},
}
