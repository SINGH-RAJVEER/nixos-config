{ config, pkgs, ... }:
{
    programs.ghostty = {
        enable = true;
        settings = {
            theme = "Dimidium";
            confirm-close-surface = false;
            font-family = [ "3270 Nerd Font Mono" ];
            font-size =18;
        };
    };
}
