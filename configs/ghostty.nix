{ config, pkgs, ... }:

{
  programs.ghostty = {
    enable = true;
    settings = {
      theme = "GitLab Dark Grey";
      confirm-close-surface = false;
      font-family = "3270 Nerd Font Mono";
      font-size = 20;
      command = "zellij";
    };
  };
}
