{ config, pkgs, ... }:

{
    programs.waybar = {
        enable = true;

        settings = {
            mainBar = {
                position = "top";
                height = 28;
                spacing = "1";
                margin = "0";

                modules-left = [
                    "niri/workspaces"
                ];

                modules-center = [
                    "clock"
                ];

                modules-right = [
                    "tray"
                    "network"
                    "custom/hotspot"
                    "bluetooth"
                    "pulseaudio"
                    "custom/kbdbrt"
                    "backlight"
                    "cpu"
                    "memory"
                    "custom/battery"
                ];

                "niri/workspaces" = {
                    all-outputs = true;
                    format = "{index}";
                };

                "niri/window" = {
                    format = "{{}}";
                };

                "custom/kbdbrt" = {
                    exec = "/home/rajveer/.config/nixos/scripts/get_kbd_bgt.sh";
                    format = "{}";
                    return-type = "json";
                    on-click = "/home/rajveer/.config/nixos/scripts/toggle_kbd_bgt.sh";
                };

                clock = {
                    format = "{:%A, %B %d, %H:%M}";
                    tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
                    calendar = {
                        mode = "month";
                        mode-mon-col = 3;
                        weeks-pos = "right";
                        format = {
                            months = "<b>{{}}</b>";
                            days = "{{}}";
                            weeks = "<b>W{{}}</b>";
                            weekdays = "<b>{{}}</b>";
                            today = "<b><u>{{}}</u></b>";
                        };
                    };
                };

                cpu = {
                    format = "󰍛  {usage}%";
                    tooltip = true;
                    interval = 5;
                };

                memory = {
                    format = "󰘚  {}%";
                    interval = 3;
                };

                "custom/hotspot" = {
                    format = "󰀂 ";
                    on-click = "nmcli connection up Hotspot";
                    on-click-middle = "nmcli connection down Hotspot";
                };

                "custom/battery" = {
                    exec = "/home/rajveer/.config/nixos/scripts/custom_battery.sh";
                    format = "{}";
                    return-type = "json";
                    on-click = "/home/rajveer/.config/nixos/scripts/toggle_ass.sh";
                };

                network = {
                    format-wifi = "{icon}  {essid}";
                    format-ethernet = "󰈀  {ifname}";
                    format-linked = "󰈀  {ifname} (No IP)";
                    format-disconnected = "󰖪  Disconnected";
                    format-icons = [ "󰤯" "󰤟" "󰤢" "󰤥" ];
                    tooltip-format = "{ifname}: {ipaddr}";
                    on-click = "nm-applet &";
                    on-click-middle = "pkill nm-applet";
                };

                pulseaudio = {
                    format = "{icon}  {volume}%";
                    format-muted = "󰝟";
                    format-icons = {
                        headphone = "󰋋";
                        hands-free = "󰥰";
                        headset = "󰋎";
                        phone = "󰏲";
                        portable = "󰄝";
                        default = [ "󰕿" "󰖀" "󰕾" ];
                    };
                    on-click = "pavucontrol";
                    on-click-right = "pactl set-sink-mute @DEFAULT_SINK@ toggle";
                    on-scroll-up = "pactl set-sink-volume @DEFAULT_SINK@ +2%";
                    on-scroll-down = "pactl set-sink-volume @DEFAULT_SINK@ -2%";
                };

                backlight = {
                    format = "{icon}   {percent}%";
                    format-icons = [ "󰃞" "󰃟" "󰃠" ];
                    on-scroll-up = "brightnessctl set +1%";
                    on-scroll-down = "brightnessctl set 1%-";
                };

                tray = {
                    icon-size = "18";
                    spacing = 10;
                };

                bluetooth = {
                    format-disabled = "󰂲  off";
                    format-connected = "󰂯  {device_alias}";
                    format-connected-battery = "󰂯  {device_alias} {device_battery_percentage}%";

                    # tooltop
                    tooltip-format = "{controller_alias}\t{controller_address}\n\n{num_connections} connected";
                    tooltip-format-connected = "{controller_alias}\t{controller_address}\n\n{num_connections} connected\n\n{device_enumerate}";
                    tooltip-format-enumerate-connected = "{device_alias}\t{device_address}";
                    tooltip-format-enumerate-connected-battery = "{device_alias}\t{device_address}\t{device_battery_percentage}%";

                    on-click = "blueman-manager";
                };
            };
        };

        style = ''

          @define-color background #2E2E2E;
          @define-color background-light #424242;
          @define-color foreground #FFFFFF;
          @define-color grey #BDBDBD;


          @define-color workspaces-color @foreground;
          @define-color workspaces-focused-bg @grey;
          @define-color workspaces-focused-fg @background;
          @define-color workspaces-urgent-bg @grey;
          @define-color workspaces-urgent-fg @background;

          * {
            border: none;
            border-radius: 0;
            font-family: "Iosevka Nerd Font";
            font-size: 14px;
            min-height: 0;
          }

          window#waybar {
            background-color: transparent;
            color: @foreground;
          }


          #mode, #clock, #tray, #network, #bluetooth, #pulseaudio, #backlight, #cpu, #custom-hotspot, #custom-playerctl, #memory, #custom-battery, #custom-playerctl, #custom-kbdbrt {
            padding: 0 10px;
            margin: 3px;
            background-color: @background-light;
            border-radius: 3px;
          }


          #workspaces {
            background-color: transparent;
          }

          #workspaces button {
            background-color: @background-light;
            color: #FFFFFF;
            border-radius: 3px;
            font-weight: 900;
            border: none;
            padding: 2px 6px;
            margin: 3px;
          }

          #workspaces button:hover {
            background: @background-focused-bg;
            box-shadow: inherit;
          }

          #workspaces button.active {
            background-color: #FFFFFF;
            color: #000000;
            border-radius: 3px;
            font-weight: 900;
            border: none;
            padding: 2px 6px;
            margin: 3px;
          }

          #workspaces button.urgent {
            background-color: @workspaces-urgent-bg;
            color: @workspaces-urgent-fg;
          }


           #mode, #clock, #cpu, #memory, #custom-battery, #network, #pulseaudio, #backlight, #bluetooth {
             color: @foreground;
           }

          #network.disconnected, #pulseaudio.muted {
            color: @grey;
          }

          #tray > .passive {
            -gtk-icon-effect: dim;
          }

          #tray > .needs-attention {
            -gtk-icon-effect: highlight;
            color: #FF0000;
            border-bottom-color: @grey;
          }

          #custom-battery.state-80 {
            background-color: green;
          }

          #custom-battery.state-100 {
            background-color: @background-light;
          }

          #custom-battery.capacity-100 {
            background-color: white;
            color: black;
          }
        '';
    };
}
