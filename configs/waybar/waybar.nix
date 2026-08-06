{ pkgs, ... }:

{
    programs.waybar = {
        enable = true;
        package = pkgs.waybar;

        systemd = {
            enable = true;
        };
    };

    xdg.configFile."waybar" = {
        source = ./config;
        recursive = true;
    };
}
