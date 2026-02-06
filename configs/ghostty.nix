{ config, pkgs, ... }:

{
  programs.ghostty = {
    enable = true;
    settings = {
      confirm-close-surface = false;
      font-size = 14;
    };
  };
}
