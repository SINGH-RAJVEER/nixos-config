{ config, pkgs, ... } :

{
    imports = [
        ./nixbox-home-packages.nix
        ./configs/starship.nix
        ./configs/nvim.nix
        ./configs/ghostty.nix
        ./configs/nushell.nix
    ];

    home = {
        username = "rajveer";
        homeDirectory = "/home/rajveer";
    };

    home.packages = with pkgs; [
    # system

        git
        pavucontrol
        exfatprogs
        brightnessctl
        xwayland-satellite
        seahorse
        qemu
        zellij
        fzf
        bat
        ripgrep
        xh
        delta
        librepods

    # development

        ## Rust
        rustc
        cargo
        rustPlatform.rustLibSrc

        ## C
        clang

        ## TS
        bun

        ## Java
        jdk

        ## Python
        python3
        uv

        ## Utilities
        just

    # GUIs

        onlyoffice-desktopeditors
        qbittorrent
        nautilus
        thunderbird
        zed-editor
        lmstudio
        anytype
        steam
        prismlauncher
        bitwarden-desktop

    # TUIs

        claude-code
        codex
        yazi
    ];

    # GTK theme config
    dconf.settings = {
        "org/gnome/desktop/interface" = {
            color-scheme = "prefer-dark";
        };
    };

    gtk = {
        enable = true;
        theme.name = "Adwaita-dark";
        gtk3.extraConfig.gtk-application-prefer-dark-theme = 1;
        gtk4 = {
            theme.name = "Adwaita-dark";
            extraConfig.gtk-application-prefer-dark-theme = 1;
        };
    };

    # Qt theme config
    qt = {
        enable = true;
        platformTheme.name = "adwaita";
        style.name = "adwaita-dark";
    };

    home.pointerCursor = {
        gtk.enable = true;
        x11.enable = true;
        package = pkgs.adwaita-icon-theme;
        name = "Adwaita";
        size = 18;
    };

    home.sessionVariables = {
        RUST_SRC_PATH = "${pkgs.rustPlatform.rustLibSrc}";
        DIRENV_LOG_FORMAT = "";
    };

    xdg.mimeApps = {
        enable = true;
    };

    xdg.desktopEntries.factorio = {
        name = "Factorio";
        exec = "/home/rajveer/Games/Factorio/launch-factorio.sh";
        icon = "/home/rajveer/Games/Factorio/data/core/graphics/factorio-icon.png";
        terminal = false;
        type = "Application";
        categories = [ "Game" ];
    };

    programs.zoxide = {
        enable = true;
        enableNushellIntegration = true;
    };

    programs.carapace = {
        enable = true;
        enableNushellIntegration = true;
    };

    programs.direnv = {
        enable = true;
        nix-direnv.enable = true;
        enableNushellIntegration = true;
    };

    programs.git = {
        enable = true;
        settings = {
            credential."https://github.com".helper = "!gh auth git-credential";
        };
    };

    home.stateVersion = "25.11";
}
