return {
	{
		'echasnovski/mini.nvim',
		config = function()
			require('mini.ai').setup { n_lines = 500 }
			require('mini.surround').setup()
			require('mini.cursorword').setup()
			require('mini.icons').setup()
			require('mini.icons').mock_nvim_web_devicons()
		end,
	},
}
