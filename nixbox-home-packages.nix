# Managed by nixbox. Do not edit by hand.
{ pkgs, ... }:
{
  home.packages = [
    # nixbox:packages:start
    pkgs.gh
    pkgs.jujutsu
    pkgs.mpv
    # nixbox:packages:end
  ];
}
