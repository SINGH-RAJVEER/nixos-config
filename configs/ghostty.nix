{ config, pkgs, ... }:

{
  programs.ghostty = {
    enable = true;
    settings = {
      theme = "GitLab Dark Grey";
      confirm-close-surface = false;
      font-size = 14;
    };
  };
}
