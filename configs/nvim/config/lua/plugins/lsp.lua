return {
	-- LSP Plugins
	{
		'folke/lazydev.nvim',
		ft = 'lua',
		opts = {
			library = {
				{ path = '${3rd}/luv/library', words = { 'vim%.uv' } },
			},
		},
	},
	{
		'neovim/nvim-lspconfig',
		dependencies = {
			{ 'mason-org/mason.nvim', opts = {} },
			{ 'mason-org/mason-lspconfig.nvim', opts = {} },
			{
				'WhoIsSethDaniel/mason-tool-installer.nvim',
				init = function()
					if not vim.env.CC and vim.fn.executable('gcc') == 0 and vim.fn.executable('clang') == 1 then
						vim.env.CC = 'clang'
					end
				end,
				opts = { ensure_installed = { 'gopls', 'golangci-lint', 'goimports' } },
			},
			{ 'j-hui/fidget.nvim', opts = {} },
			'saghen/blink.cmp',
		},
		config = function()
			local lsp_attach_group = vim.api.nvim_create_augroup('lsp-attach', { clear = true })
			vim.api.nvim_create_autocmd('LspAttach', {
				group = lsp_attach_group,
				callback = function(event)
					local map = function(keys, func, desc, mode)
						mode = mode or 'n'
						vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
					end
					vim.keymap.set('n', 'grn', function()
						return ':IncRename ' .. vim.fn.expand '<cword>'
					end, { buffer = event.buf, expr = true, desc = 'LSP: [R]e[n]ame' })
					vim.keymap.set('n', '<F2>', function()
						return ':IncRename ' .. vim.fn.expand '<cword>'
					end, { buffer = event.buf, expr = true, desc = 'LSP: [R]e[n]ame' })
					map('gra', vim.lsp.buf.code_action, '[G]oto Code [A]ction', { 'n', 'x' })
					map('grr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
					map('gri', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
					map('grd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
					map('grD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
					map('gO', require('telescope.builtin').lsp_document_symbols, 'Open Document Symbols')
					map('gW', require('telescope.builtin').lsp_dynamic_workspace_symbols, 'Open Workspace Symbols')
					map('grt', require('telescope.builtin').lsp_type_definitions, '[G]oto [T]ype Definition')
				end,
			})
			vim.diagnostic.config {
				severity_sort = true,
				float = { border = 'rounded', source = 'if_many' },
				underline = { severity = vim.diagnostic.severity.ERROR },
				signs = {
					text = {
						[vim.diagnostic.severity.ERROR] = '󰅚 ',
						[vim.diagnostic.severity.WARN] = '󰀪 ',
						[vim.diagnostic.severity.INFO] = '󰋽 ',
						[vim.diagnostic.severity.HINT] = '󰌶 ',
					},
				},
				virtual_text = {
					source = 'if_many',
					spacing = 2,
				},
			}
			local servers = {
				gopls = {},
				rust_analyzer = {},
				terraformls = {},
				basedpyright = {
					settings = {
						basedpyright = {
							analysis = {
								autoImportCompletions = true,
								diagnosticMode = 'workspace',
								typeCheckingMode = 'standard',
							},
						},
					},
				},
				ruff = {
					on_attach = function(client)
						-- BasedPyright owns type information and Black owns formatting.
						client.server_capabilities.hoverProvider = false
						client.server_capabilities.documentFormattingProvider = false
						client.server_capabilities.documentRangeFormattingProvider = false
					end,
				},
				ts_ls = {
					on_attach = function(client)
						client.server_capabilities.documentFormattingProvider = false
						client.server_capabilities.documentRangeFormattingProvider = false
					end,
				},
				biome = {},
				tailwindcss = {},
				lua_ls = {
					settings = {
						Lua = {
							completion = {
								callSnippet = 'Replace',
							},
						},
					},
				},
			}
			for server_name, server in pairs(servers) do
				server.capabilities = require('blink.cmp').get_lsp_capabilities(server.capabilities)
				vim.lsp.config(server_name, server)
			end

			require('mason-lspconfig').setup {
				automatic_enable = { exclude = { 'pyright' } },
			}
			vim.lsp.enable('pyright', false)

			for server_name in pairs(servers) do
				vim.lsp.enable(server_name)
			end
		end,
	},
}
