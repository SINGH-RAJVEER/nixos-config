{ pkgs, ... }: {
    programs.neovim = {
        enable = true;
        withNodeJs = true;
        withPython3 = true;
        extraPackages = with pkgs; [
            stylua
            pyright
            typescript-language-server
            lua-language-server
            rust-analyzer
        ];
    };
}