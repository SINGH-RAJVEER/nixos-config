# Managed by nixbox. Do not edit by hand.
{ pkgs, ... }:
{
  home.packages = [
    # nixbox:packages:start
    pkgs.bat
    pkgs.brightnessctl
    pkgs.bun
    pkgs.cargo
    pkgs.clang
    pkgs.clippy
    pkgs.codex
    pkgs.delta
    pkgs.devenv
    pkgs.discord
    pkgs.eza
    pkgs.fzf
    pkgs.gh
    pkgs.git
    pkgs.go
    pkgs.imv
    pkgs.jdk
    pkgs.jujutsu
    pkgs.just
    pkgs.lazygit
    pkgs.librepods
    pkgs.lmstudio
    pkgs.mission-center
    pkgs.mpv
    pkgs.nautilus
    pkgs.ncdu
    pkgs.obsidian
    pkgs.onlyoffice-desktopeditors
    pkgs.opencode
    pkgs.opencode-desktop
    pkgs.pavucontrol
    pkgs.pi-coding-agent
    pkgs.python3
    pkgs.qbittorrent
    pkgs.ripgrep
    pkgs.rust-analyzer
    pkgs.rustPlatform.rustLibSrc
    pkgs.rustc
    pkgs.rustfmt
    pkgs.swi-prolog-gui
    pkgs.thunderbird
    pkgs.unzip
    pkgs.uv
    pkgs.xh
    pkgs.xwayland-satellite
    pkgs.yazi
    pkgs.zed-editor
    pkgs.zellij
    # nixbox:packages:end
  ];
}
