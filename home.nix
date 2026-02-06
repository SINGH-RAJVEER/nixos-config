{ config, pkgs, inputs, ... } :

{
    imports = [
        ./configs/starship.nix
        ./configs/nvim.nix
        ./configs/hypr/hypridle.nix
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
        zellij
        lsof

        # development
        rustc
        cargo
        clang
        gnumake
        bun
        nodejs_24
        biome
        jdk
        maven
        python314
        uv
        maven
        postgresql
        docker-compose
        just

        # GUIs
        virt-manager
        anytype
        mpv
        onlyoffice-desktopeditors
        nautilus
        papers
        resources
        qbittorrent
        image-roll
        vscode
        code-cursor
        zed-editor-fhs
        github-desktop
        insomnia
        mongodb-compass
        kdePackages.plasma-systemmonitor

        # TUIs
        eza
        fzf
        bat
        ripgrep
        xh
        delta
        gemini-cli
        opencode
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

