{ config, inputs, pkgs, ... } :

{
    imports = [
        ./nixbox-home-packages.nix
        ./configs/starship.nix
        ./configs/nvim.nix
        ./configs/ghostty.nix
        ./configs/nushell.nix
        inputs.noctalia.homeModules.default
        inputs.helium-browser.homeModules.default
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
        zellij
        fzf
        bat
        ripgrep
        delta
        librepods

    # development
        rustc
        cargo
        rustfmt
        rust-analyzer
        clippy
        rustPlatform.rustLibSrc
        clang
        bun
        jdk
        python3
        uv
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
        inputs.zen-browser.packages."${pkgs.stdenv.hostPlatform.system}".default
        # bitwarden-desktop

    # TUIs
        codex
        pi-coding-agent
        opencode
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

    # cursor
    home.pointerCursor = {
        gtk.enable = true;
        x11.enable = true;
        package = pkgs.adwaita-icon-theme;
        name = "Adwaita";
        size = 18;
    };

    # session variables
    home.sessionVariables = {
        RUST_SRC_PATH = "${pkgs.rustPlatform.rustLibSrc}";
    };

    # xdg
    xdg.mimeApps.enable = true;

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

    programs.noctalia = {
        enable = true;
        systemd.enable = true;
    };

    programs.helium = {
        enable = true;
        flags = [
            "--ozone-platform-hint=auto"
        ];
    };

    programs.git = {
        enable = true;
        settings = {
            credential."https://github.com".helper = "!gh auth git-credential";
        };
    };

    home.stateVersion = "26.05";
}
