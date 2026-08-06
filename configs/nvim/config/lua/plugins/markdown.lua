return {
	{
		'MeanderingProgrammer/render-markdown.nvim',
		ft = { 'markdown' },
		dependencies = {
			'nvim-treesitter/nvim-treesitter',
			'echasnovski/mini.nvim',
		},
		init = function()
			vim.api.nvim_create_autocmd('FileType', {
				pattern = 'markdown',
				callback = function()
					vim.opt_local.conceallevel = 2
					vim.opt_local.concealcursor = ''
				end,
			})
		end,
		opts = {},
	},
}
