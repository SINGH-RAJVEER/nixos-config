{ pkgs, ... }: {
    programs.neovim = {
        enable = true;
        withNodeJs = true;
        withPython3 = true;
        withRuby = false;
        sideloadInitLua = true;

        extraPackages = with pkgs; [
            # LSP servers
            lua-language-server
            pyright
            typescript-language-server
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
    };

    xdg.configFile."nvim" = {
        source = ./config;
        recursive = true;
    };
}
