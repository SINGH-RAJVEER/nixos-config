{ config, pkgs, inputs, ... } :

{
   imports = [
     ./configs/wofi.nix
     ./configs/starship.nix
     ./configs/waybar.nix
     ./configs/hypr/hyprlock.nix
     ./configs/nvim.nix
   ];

  home = {
    username = "rajveer";
    homeDirectory = "/home/rajveer";
  };

  home.packages = with pkgs; [
    # TUIs
    eza
    zoxide
    fzf
    bat
    ripgrep
    xh
    delta
    gemini-cli
    opencode
    ncdu
    yazi

    # system
    git
    zsh
    networkmanagerapplet
    swww
    pavucontrol
    blueman
    exfatprogs
    brightnessctl
    swaynotificationcenter
    xwayland-satellite
    seahorse

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
    mongosh
    vscode
    code-cursor
    zed-editor

    # GUIs
    ghostty
    anytype
    mpv
    thunderbird
    steam
    libreoffice
    nautilus
    papers
    mission-center
    discord
    qbittorrent
    gnome-calculator
    image-roll
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
      "image/jpeg" = "image-roll.desktop";
      "image/png" = "image-roll.desktop";
      "image/gif" = "image-roll.desktop";
      "image/webp" = "image-roll.desktop";
      "image/bmp" = "image-roll.desktop";
      "image/svg+xml" = "image-roll.desktop";
    };
  };

  home.stateVersion = "25.05";
}

