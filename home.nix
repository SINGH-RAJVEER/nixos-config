{ config, pkgs, inputs, ... } :

{
    imports = [
        ./configs/starship.nix
        ./configs/nvim.nix
        ./configs/hypridle.nix
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
        networkmanagerapplet
        brightnessctl
        xwayland-satellite
        unzip
        zellij
        lsof

        # development
        rustc
        cargo
        clang
        bun
        biome
        jdk
        maven
        python3
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
        qbittorrent
        image-roll
        vscode-fhs
        antigravity-fhs
        code-cursor-fhs
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

