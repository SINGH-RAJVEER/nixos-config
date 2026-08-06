return {
	{
		'folke/which-key.nvim',
		event = 'VimEnter',
		opts = {
			delay = 0,
			spec = {
				{ '<leader>g', group = '[G]it/Jujutsu' },
				{ '<leader>s', group = '[S]earch' },
				{ '<leader>t', group = '[T]oggle' },
				{ '<leader>j', group = '[J]upyter' },
			},
		},
	},
}
