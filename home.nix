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
        javaPackages.compiler.openjdk21
        maven
        graphite-cli
        radicle-tui
        radicle-desktop
        nodejs_25

        # GUIs
        ghostty
        anytype
        mpv
        onlyoffice-desktopeditors
        nautilus
        papers
        mission-center
        qbittorrent
        image-roll
        vscode
        code-cursor
        zed-editor

        # TUIs
        eza
        zoxide
        fzf
        bat
        ripgrep
        xh
        delta
        gemini-cli
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
            #pdf
            "application/pdf" = "org.gnome.Papers.desktop";

            #browser
            "x-scheme-handler/http" = "zen.desktop";
            "x-scheme-handler/https" = "zen.desktop";
            "text/html" = "zen.desktop";
            "application/xhtml+xml" = "zen.desktop";
        };
    };

    home.stateVersion = "25.11";
}

