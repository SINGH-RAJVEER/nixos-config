return {
	{
		'smjonas/inc-rename.nvim',
		opts = {},
	},

	{
		'lewis6991/gitsigns.nvim',
		opts = {
			signs = {
				add = { text = '+' },
				change = { text = '~' },
				delete = { text = '_' },
				topdelete = { text = '‾' },
				changedelete = { text = '~' },
			},
		},
	},

	{
		'nvim-neo-tree/neo-tree.nvim',
		branch = 'v3.x',
		cmd = 'Neotree',
		dependencies = {
			'nvim-lua/plenary.nvim',
			'MunifTanjim/nui.nvim',
		},
		keys = {
			{ '<leader>e', '<cmd>Neotree toggle<cr>', desc = 'Toggle file explorer' },
		},
		opts = {
			default_component_configs = {
				icon = {
					folder_empty = '󰜌',
					folder_empty_open = '󰜌',
				},
				git_status = {
					symbols = {
						renamed = '➜',
						untracked = '★',
						ignored = '◌',
						staged = '✓',
					},
				},
			},
			filesystem = {
				follow_current_file = {
					enabled = true,
				},
				use_libuv_file_watcher = true,
				filtered_items = {
					visible = true,
					hide_dotfiles = false,
					hide_gitignored = false,
				},
			},
		},
	},

	{ 'folke/todo-comments.nvim', event = 'VimEnter', dependencies = { 'nvim-lua/plenary.nvim' }, opts = { signs = false } },

}
