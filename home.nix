{ config, pkgs, inputs, ... } :

{
    imports = [
        ./configs/starship.nix
        ./configs/nvim.nix
        ./configs/hypr/hypridle.nix
    ];

    home = {
        username = "rajveer";
        homeDirectory = "/home/rajveer";
    };

    home.packages = with pkgs; [
        # system
        git
        zsh
        pavucontrol
        exfatprogs
        brightnessctl
        xwayland-satellite
        unzip
        networkmanagerapplet
        blueman

        # development
        rustc
        cargo
        gcc
        cmake
        bun
        python314
        go
        jdk
        uv
        insomnia
        mongodb-compass
        vscode
        code-cursor
        javaPackages.compiler.openjdk21
        maven
        graphite-cli

        # GUIs
        ghostty
        anytype
        mpv
        onlyoffice-desktopeditors
        nautilus
        papers
        mission-center
        qbittorrent
        gnome-calculator
        image-roll
        slack
        virtualbox
        gnome-disk-utility
        discord

        # TUIs
        eza
        zoxide
        fzf
        bat
        ripgrep
        xh
        delta
        gemini-cli
#        opencode
        ncdu
        yazi
    ];

    # GTK theme configuration
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

    # Qt theme configuration
    qt = {
        enable = true;
        platformTheme.name = "adwaita";
        style.name = "adwaita-dark";
    };

    # cursor
    home.pointerCursor = {
        gtk.enable = true;
        x11.enable = true;
        package = pkgs.adwaita-icon-theme;
        name = "Adwaita";
        size = 20;
    };

    xdg.mimeApps = {
        enable = true;
        defaultApplications = {
            "application/pdf" = "org.gnome.Papers.desktop";
        };
    };

    home.stateVersion = "25.11";
}

