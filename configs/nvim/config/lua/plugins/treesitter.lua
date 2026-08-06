local parsers = {
  'bash',
  'c',
  'cpp',
  'css',
  'desktop',
  'diff',
  'dockerfile',
  'git_config',
  'gitcommit',
  'gitignore',
  'html',
  'hyprlang',
  'ini',
  'java',
  'javascript',
  'json',
  'just',
  'kdl',
  'lua',
  'luadoc',
  'markdown',
  'markdown_inline',
  'nix',
  'python',
  'query',
  'regex',
  'rust',
  'toml',
  'tsx',
  'typescript',
  'vim',
  'vimdoc',
  'yaml',
}

return {
  {
    'nvim-treesitter/nvim-treesitter',
    branch = 'main',
    build = function()
      local treesitter = require('nvim-treesitter')
      treesitter.update():wait(300000)
      treesitter.install(parsers):wait(300000)
    end,
    config = function()
      vim.api.nvim_create_autocmd('FileType', {
        callback = function(args)
          if pcall(vim.treesitter.start, args.buf) and args.match ~= 'ruby' then
            vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
          end
        end,
      })
    end,
  },
  {
    'windwp/nvim-ts-autotag',
    opts = {},
  },
}
