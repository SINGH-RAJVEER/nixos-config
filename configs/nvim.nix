{ pkgs, ... }: {
    programs.neovim = {
        enable = true;
        withNodeJs = true;
        withPython3 = true;
        withRuby = false;
        extraPackages = with pkgs; [
            # LSP servers
            lua-language-server
            pyright
            typescript-language-server
            rust-analyzer
            tailwindcss-language-server
            biome

            # Formatters
            stylua
            black
            google-java-format

            # Linters
            ruff
        ];
        extraPython3Packages = ps: with ps; [
            pynvim
            jupyter-client
            nbformat
        ];
        initLua = ''
            vim.g.mapleader = ' '
            vim.g.maplocalleader = ' '
            vim.g.have_nerd_font = true

            require('config.options')
            require('config.keymaps')
            require('config.autocmds')
            require('config.lazy')
        '';
    };
}
