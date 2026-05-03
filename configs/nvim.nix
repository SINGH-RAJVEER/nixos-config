{ pkgs, ... }: {
    programs.neovim = {
        enable = true;
        withNodeJs = true;
        withPython3 = true;
        withRuby = false;
        initLua = ''
            vim.g.mapleader = ' '
            vim.g.maplocalleader = ' '
            vim.g.have_nerd_font = true

            require('config.options')
            require('config.keymaps')
            require('config.autocmds')
            require('config.lazy')
        '';
        extraPackages = with pkgs; [
            stylua
            pyright
            typescript-language-server
            lua-language-server
            rust-analyzer
        ];
        extraPython3Packages = ps: with ps; [
            pynvim
            jupyter-client
            nbformat
        ];
    };
}
