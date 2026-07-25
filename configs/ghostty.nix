{ config, pkgs, ... }:
{
    programs.ghostty = {
        enable = true;
        settings = {
            command = "zellij";
            theme = "Dimidium";
            confirm-close-surface = false;
            font-size = 14;
        };
    };
}
