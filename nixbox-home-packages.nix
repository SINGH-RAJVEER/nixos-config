# Managed by nixbox. Do not edit by hand.
{ pkgs, ... }:
{
  home.packages = [
    # nixbox:packages:start
    pkgs.gh
    pkgs.imv
    pkgs.jujutsu
    pkgs.mission-center
    pkgs.mpv
    pkgs.ncdu
    pkgs.obsidian
    pkgs.unzip
    # nixbox:packages:end
  ];
}
