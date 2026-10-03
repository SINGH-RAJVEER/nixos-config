# Managed by nixbox. Do not edit by hand.
{ pkgs, ... }:
{
  home.packages = [
    # nixbox:packages:start
    pkgs.bat
    pkgs.brightnessctl
    pkgs.claude-code
    pkgs.codex
    pkgs.delta
    pkgs.devenv
    pkgs.discord
    pkgs.dunst
    pkgs.exfatprogs
    pkgs.fd
    pkgs.fzf
    pkgs.gh
    pkgs.git
    pkgs.hunk
    pkgs.ironbar
    pkgs.jujutsu
    pkgs.lmstudio
    pkgs.mangowc
    pkgs.mission-center
    pkgs.mpv
    pkgs.nwg-displays
    pkgs.nwg-look
    pkgs.obsidian
    pkgs.onlyoffice-desktopeditors
    pkgs.opencode
    pkgs.openssl
    pkgs.pavucontrol
    pkgs.pcmanfm
    pkgs.podman-desktop
    pkgs.qbittorrent
    pkgs.ripgrep
    pkgs.seahorse
    pkgs.t3code
    pkgs.thunderbird
    pkgs.tor-browser
    pkgs.xwayland-satellite
    pkgs.zellij
    # nixbox:packages:end
  ];
}
