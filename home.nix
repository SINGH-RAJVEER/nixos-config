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
        brightnessctl
        xwayland-satellite
        unzip
        zellij
        lsof
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
        biome

        ## Java
        jdk

        ## Python
        python3
        uv

        ## Docker
        docker-compose

        ## Utilities
        just
        gh

    # GUIs
        virt-manager
        mpv
        onlyoffice-desktopeditors
        qbittorrent
        image-roll
        sioyek
        insomnia
        github-desktop
        discord
        prismlauncher

        ## Editors
        vscode-fhs
        antigravity-fhs
        code-cursor-fhs
        zed-editor

    # TUIs

        ## Agentic CLIs
        gemini-cli
        codex
        github-copilot-cli
        opencode
        heretic

        ## Utilities
        ncdu
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

