# Managed by nixbox. Do not edit by hand.
{ pkgs, ... }:
{
  home.packages = [
    # nixbox:packages:start
    pkgs.gh
    pkgs.go
    pkgs.imv
    pkgs.jujutsu
    pkgs.lazygit
    pkgs.mission-center
    pkgs.mpv
    pkgs.ncdu
    pkgs.obsidian
    pkgs.qbittorrent
    pkgs.swi-prolog-gui
    pkgs.unzip
    pkgs.xh
    # nixbox:packages:end
  ];
}
