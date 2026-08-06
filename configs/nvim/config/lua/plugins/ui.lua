return {
  -- Colorscheme
  {
    'ellisonleao/gruvbox.nvim',
    priority = 1000,
    config = function()
      require('gruvbox').setup {
        contrast = 'hard',
      }
      vim.cmd.colorscheme 'gruvbox'
    end,
  },

  -- Noice
  {
    'folke/noice.nvim',
    event = 'VeryLazy',
    opts = {
      lsp = {
        -- Override LSP markdown rendering with Treesitter.
        override = {
          ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
          ['vim.lsp.util.stylize_markdown'] = true,
        },
      },
      presets = {
        bottom_search = true,
        command_palette = true,
        long_message_to_split = true,
        inc_rename = true,
        lsp_doc_border = false,
      },
    },
    dependencies = {
      'MunifTanjim/nui.nvim',
    },
  },

  -- Indentation guides
  {
    'lukas-reineke/indent-blankline.nvim',
    main = 'ibl',
    ---@module "ibl"
    ---@type ibl.config
    opts = {
      indent = {
        highlight = {
          'RainbowRed',
          'RainbowYellow',
          'RainbowBlue',
          'RainbowOrange',
          'RainbowGreen',
          'RainbowViolet',
          'RainbowCyan',
        },
      },
    },
    config = function(_, opts)
      local hooks = require 'ibl.hooks'

      hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
        vim.api.nvim_set_hl(0, 'RainbowRed', { fg = '#fb4934' })
        vim.api.nvim_set_hl(0, 'RainbowYellow', { fg = '#fabd2f' })
        vim.api.nvim_set_hl(0, 'RainbowBlue', { fg = '#83a598' })
        vim.api.nvim_set_hl(0, 'RainbowOrange', { fg = '#fe8019' })
        vim.api.nvim_set_hl(0, 'RainbowGreen', { fg = '#b8bb26' })
        vim.api.nvim_set_hl(0, 'RainbowViolet', { fg = '#d3869b' })
        vim.api.nvim_set_hl(0, 'RainbowCyan', { fg = '#8ec07c' })
      end)
      require('ibl').setup(opts)
    end,
  },
}
