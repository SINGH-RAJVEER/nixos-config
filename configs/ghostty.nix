{ config, pkgs, ... }:
{
    programs.ghostty = {
        enable = true;
        settings = {
            theme = "Dimidium";
            confirm-close-surface = false;
            font-size = 14;
            command = "zellij";
        };
    };
}
