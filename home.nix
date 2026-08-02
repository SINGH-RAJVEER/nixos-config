{ config, inputs, lib, pkgs, ... } :

{
    imports = [
        ./nixbox-home-packages.nix
        ./configs/starship.nix
        ./configs/nvim.nix
        ./configs/ghostty.nix
        ./configs/nushell.nix
        ./configs/zellij.nix
        inputs.noctalia.homeModules.default
        inputs.helium-browser.homeModules.default
    ];

    home = {
        username = "rajveer";
        homeDirectory = "/home/rajveer";
        enableNixpkgsReleaseCheck = false;
    };

    home.packages = with pkgs; [
    # GUIs
        inputs.zen-browser.packages."${pkgs.stdenv.hostPlatform.system}".default
        inputs.sidra.packages."${pkgs.stdenv.hostPlatform.system}".default
        inputs.claude-desktop.packages."${pkgs.stdenv.hostPlatform.system}".default
        inputs.omnyssh.packages.${pkgs.system}.default
    ];

    # GTK theme config
    dconf.settings = {
        "org/gnome/desktop/interface" = {
            color-scheme = "prefer-dark";
        };
    };

    gtk = {
        enable = true;
        theme = {
            name = "Adwaita-dark";
            package = pkgs.gnome-themes-extra;
        };
        iconTheme = {
            name = "Adwaita";
            package = pkgs.adwaita-icon-theme;
        };
    };

    # Qt theme config
    qt = {
        enable = true;
        platformTheme.name = "adwaita";
        style = {
            name = "adwaita-dark";
            package = pkgs.adwaita-qt;
        };
    };

    home = {
        sessionVariables = {
            RUST_SRC_PATH = "${pkgs.rustPlatform.rustLibSrc}";
            GTK_THEME = "Adwaita:dark";
        };
        stateVersion = "26.05";
    };

    xdg = {
        mimeApps = {
            enable = true;
            defaultApplications = let
                browser = "zen-beta.desktop";
            in lib.mkForce {
                "application/xhtml+xml" = browser;
                "application/xml" = browser;
                "text/html" = browser;
                "text/xml" = browser;
                "x-scheme-handler/http" = browser;
                "x-scheme-handler/https" = browser;
            };
        };
        desktopEntries.factorio = {
            name = "Factorio";
            exec = "/home/rajveer/Games/Factorio/launch-factorio.sh";
            icon = "/home/rajveer/Games/Factorio/data/core/graphics/factorio-icon.png";
            terminal = false;
            type = "Application";
            categories = [ "Game" ];
        };
    };

    programs = {
        zoxide = {
            enable = true;
            enableNushellIntegration = true;
        };

        carapace = {
            enable = true;
            enableNushellIntegration = true;
        };

        direnv = {
            enable = true;
            nix-direnv.enable = true;
            enableNushellIntegration = true;
        };

        noctalia = {
            enable = true;
            systemd.enable = true;
        };

        helium = {
            enable = true;
            flags = [
                "--ozone-platform-hint=auto"
            ];
        };

        git = {
            enable = true;
            settings = {
                credential."https://github.com".helper = "!gh auth git-credential";
            };
        };
    };
}
