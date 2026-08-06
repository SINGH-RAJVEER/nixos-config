return {
	-- Autoformat
	{
		'stevearc/conform.nvim',
		event = { 'BufReadPre', 'BufNewFile' },
		cmd = { 'ConformInfo' },
		keys = {
			{
				'<leader>f',
				function()
					require('conform').format { async = true, lsp_format = 'fallback' }
				end,
				mode = '',
				desc = '[F]ormat buffer',
			},
		},
		opts = {
			notify_on_error = false,
			formatters_by_ft = {
				go = { 'goimports' },
				lua = { 'stylua' },
				python = { 'black' },
				javascript = { 'biome' },
				typescript = { 'biome_typescript' },
				javascriptreact = { 'biome' },
				typescriptreact = { 'biome_typescript' },
				json = { 'biome' },
				jsonc = { 'biome' },
				json5 = { 'biome' },
				css = { 'biome' },
				graphql = { 'biome' },
				rust = { 'rustfmt' },
				java = { 'google-java-format' },
			},
			formatters = {
				biome_typescript = {
					inherit = 'biome',
					prepend_args = {
						'--javascript-formatter-indent-style=space',
						'--javascript-formatter-indent-width=4',
						'--trailing-commas=none',
					},
				},
			},
		},
	},
}
