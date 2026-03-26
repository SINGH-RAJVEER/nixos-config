{ config, pkgs, inputs, ... } :

{
    imports = [
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
        unzip
        seahorse
        zellij
        eza
        fzf
        bat
        ripgrep
        xh
        delta

    # development

        ## Rust
        rustc
        cargo

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
        mpv
        onlyoffice-desktopeditors
        qbittorrent
        image-roll
        nautilus
        sioyek
        thunderbird
        mission-center
        anytype
        obsidian

    # TUIs

        ## Agentic CLIs
        claude-code
        gemini-cli
        codex
        opencode

        ## Utilities
        ncdu
        yazi
        gh

    # Games
        steam
        discord
        prismlauncher
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
        gtk4.extraConfig.gtk-application-prefer-dark-theme = 1;
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

    xdg.mimeApps = {
        enable = true;
        defaultApplications = {
            "application/pdf" = "sioyek.desktop";
        };
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

    home.stateVersion = "25.11";
}
