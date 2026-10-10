# Managed by nixbox. Do not edit by hand.
{ pkgs, ... }:
{
  home.packages = [
    # nixbox:packages:start
    pkgs.bat
    pkgs.brightnessctl
    pkgs.claude-code
    pkgs.codex
    pkgs.devenv
    pkgs.discord
    pkgs.exfatprogs
    pkgs.fd
    pkgs.fzf
    pkgs.gh
    pkgs.git
    pkgs.hunk
    pkgs.jujutsu
    pkgs.lmstudio
    pkgs.mission-center
    pkgs.mpv
    pkgs.obsidian
    pkgs.onlyoffice-desktopeditors
    pkgs.openssl
    pkgs.pavucontrol
    pkgs.pcmanfm
    pkgs.podman-desktop
    pkgs.qbittorrent
    pkgs.ripgrep
    pkgs.seahorse
    pkgs.steam
    pkgs.t3code
    pkgs.thunderbird
    pkgs.tor-browser
    pkgs.xwayland-satellite
    pkgs.zellij
    # nixbox:packages:end
  ];
}
