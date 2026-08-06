return {
	{
		'saghen/blink.cmp',
		event = 'VimEnter',
		version = '1.*',
		opts = {
			keymap = {
				['<Tab>'] = { 'select_next', 'snippet_forward', 'fallback' },
				['<S-Tab>'] = { 'select_prev', 'snippet_backward', 'fallback' },
				['<CR>'] = { 'accept', 'fallback' },
			},
			completion = {
				documentation = {
					auto_show = true,
					auto_show_delay_ms = 200,
				},
				ghost_text = {
					enabled = true,
				},
				list = {
					selection = {
						auto_insert = false,
					},
				},
				menu = {
					draw = {
						columns = {
							{ 'label', 'label_description', gap = 1 },
							{ 'kind_icon', 'kind', gap = 1 },
						},
					},
				},
			},
			sources = {
				default = { 'lsp', 'path', 'snippets', 'buffer', 'lazydev' },
				providers = {
					lazydev = { module = 'lazydev.integrations.blink', score_offset = 100 },
					buffer = {
						min_keyword_length = 3,
						max_items = 5,
					},
				},
			},
			signature = { enabled = true },
		},
	},
}
