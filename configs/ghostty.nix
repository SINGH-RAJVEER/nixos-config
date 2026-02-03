{ config, pkgs, ... }:

{
  programs.ghostty = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      font-size = 14;
    };
  };
}
