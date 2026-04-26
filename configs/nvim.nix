{ pkgs, ... }: {
    programs.neovim = {
        enable = true;
        withNodeJs = true;
        withPython3 = true;
        withRuby = false;
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
