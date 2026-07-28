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
    pkgs.exfatprogs
    pkgs.eza
    pkgs.fzf
    pkgs.gh
    pkgs.git
    pkgs.go
    pkgs.hunk
    pkgs.jdk
    pkgs.jujutsu
    pkgs.just
    pkgs.libreoffice
    pkgs.lmstudio
    pkgs.mission-center
    pkgs.mpv
    pkgs.nautilus
    pkgs.ncdu
    pkgs.obsidian
    pkgs.onlyoffice-desktopeditors
    pkgs.opencode
    pkgs.pavucontrol
    pkgs.pi-coding-agent
    pkgs.python3
    pkgs.qbittorrent
    pkgs.ripgrep
    pkgs.rust-analyzer
    pkgs.rustPlatform.rustLibSrc
    pkgs.rustc
    pkgs.rustfmt
    pkgs.secretspec
    pkgs.swi-prolog
    pkgs.t3code
    pkgs.thunderbird
    pkgs.unzip
    pkgs.uv
    pkgs.xh
    pkgs.xwayland-satellite
    pkgs.zed-editor
    pkgs.zellij
    # nixbox:packages:end
  ];
}
