return {
	{
		'NicolasGB/jj.nvim',
		version = '*',
		cmd = { 'J', 'Jbrowse', 'Jdiff', 'Jedit', 'Jhdiff', 'Jread', 'Jsplit', 'Jtabedit', 'Jvdiff', 'Jvsplit' },
		dependencies = { 'folke/snacks.nvim' },
		keys = {
			{ '<leader>gg', '<cmd>J log<cr>', desc = 'Jujutsu log' },
			{ '<leader>gs', '<cmd>J status<cr>', desc = 'Jujutsu status' },
			{ '<leader>gd', '<cmd>J diff<cr>', desc = 'Jujutsu diff' },
		},
		opts = {
			diff = { backend = 'native' },
			picker = { snacks = {} },
		},
	},
}
