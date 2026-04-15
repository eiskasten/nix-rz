{ self, inputs, ... }:
{
  flake.homeModules.r3sSway =
    {
      config,
      pkgs,
      lib,
      inputs,
      ...
    }:
    {

      # stylix.enable = true;
      # stylix.fonts = {
      # emoji = {
      # package = pkgs.font-awesome_6;
      # name = "FontAwesome";
      # };
      # };

      services.kanshi = {
        enable = true;
        settings = [
          {
            output = {
              alias = "INTERNAL";
              criteria = "BOE 0x07DB Unknown";
              mode = "1920x1080@60";
              transform = "normal";
              scale = 1.0;
            };
          }

          {
            output = {
              alias = "KEMPFENDORF_CENTER";
              criteria = "Ancor Communications Inc ASUS VN247 E9LMTF006194";
              mode = "1920x1080@60";
              transform = "normal";
              scale = 1.0;
            };
          }

          {
            profile = {
              name = "kempfendorf";
              outputs = [
                {
                  criteria = "$INTERNAL";
                  position = "1920,0";
                  status = "enable";
                }
                {
                  criteria = "$KEMPFENDORF_CENTER";
                  position = "0,0";
                  status = "enable";
                }
              ];
            };
          }
        ];
      };

      programs.waybar = {
        enable = true;
        settings.main = {
          layer = "top";
          position = "top";
          height = 8;
          # output = [ "eDP-1" "HDMI-A-1" ];
          modules-left = [
            "sway/workspaces"
            "sway/mode"
          ];
          modules-center = [ ];
          modules-right = [
            "mpris"
            "wireplumber"
            "network"
            "memory"
            "battery"
            "clock"
            "tray"
          ];

          "sway/workspaces" = {
            disable-scroll = true;
            all-outputs = true;
          };

          network = {
            interface = "eth0";
            format = "{ifname}: {ipaddr}/{cidr}";
            format-wifi = "{ifname}: {ipaddr}/{cidr} ";
            format-ethernet = "{ifname}: {ipaddr}/{cidr} ";
            format-disconnected = ""; # An empty format will hide the module
            tooltip-format = "{ifname} via {gwaddr}";
            tooltip-format-wifi = "{essid} ({signalStrength}%) via {gwaddr}";
            tooltip-format-ethernet = "{ifname} via {gwaddr}";
            tooltip-format-disconnected = "{ifname}: Disconnected";
          };
          wireplumber = {
            format = "{volume}% {icon}";
            format-muted = "";
            on-click = "helvum";
            format-icons = [
              ""
              ""
              ""
            ];
          };
          memory = {
            interval = 5;
            format = "{used:0.1f}G/{total:0.1f}G ";
          };
          battery = {
            bat = "BAT2";
            interval = 60;
            states = {
              warning = 30;
              critical = 15;
            };
            format = "{capacity}% {icon}";
            format-icons = [
              ""
              ""
              ""
              ""
              ""
            ];
          };

          clock = {
            format = "{:%Y-%m-%d %H:%M}  ";
            format-alt = "{:%A, %B %d, %Y (%R)}  ";
            tooltip-format = "<tt><small>{calendar}</small></tt>";
            calendar = {
              mode = "year";
              mode-mon-col = 3;
              weeks-pos = "right";
              on-scroll = 1;
              format = {
                months = "<span color='#ffead3'><b>{}</b></span>";
                days = "<span color='#ecc6d9'><b>{}</b></span>";
                weeks = "<span color='#99ffdd'><b>W{}</b></span>";
                weekdays = "<span color='#ffcc66'><b>{}</b></span>";
                today = "<span color='#ff6699'><b><u>{}</u></b></span>";

              };
              actions = {
                on-click-right = "mode";

                on-scroll-up = "shift_up";
                on-scroll-down = "shift_down";
              };
            };
          };
        };
      };

      programs.foot.enable = true;

      # stylix.targets.waybar.font = "emoji";

      wayland.windowManager.sway.checkConfig = false; # required since xkb_layout is registered system-wide which home-manager is not aware of ;(
      wayland.windowManager.sway = {
        enable = true;
        wrapperFeatures.gtk = true;
        config = {
          input = {
            "*" = {
              xkb_layout = "kdf";
            };
          };

          modifier = "Mod4";
          left = "h";
          down = "j";
          up = "k";
          right = "l";
          keybindings =
            let
              mod = config.wayland.windowManager.sway.config.modifier;
            in
            lib.mkOptionDefault {
              # Use pactl to adjust volume in PulseAudio.
              XF86AudioRaiseVolume = "exec --no-startup-id pactl set-sink-volume @DEFAULT_SINK@ +10% && $refresh_i3status";
              XF86AudioLowerVolume = "exec --no-startup-id pactl set-sink-volume @DEFAULT_SINK@ -10% && $refresh_i3status";
              XF86AudioMute = "exec --no-startup-id pactl set-sink-mute @DEFAULT_SINK@ toggle && $refresh_i3status";
              XF86AudioMicMute = "exec --no-startup-id pactl set-source-mute @DEFAULT_SOURCE@ toggle && $refresh_i3status";

              # screen brightness
              #bindsym XF86MonBrightnessUp exec --no-startup-id light -A 10
              #bindsym XF86MonBrightnessDown exec --no-startup-id light -U 10

              XF86MonBrightnessDown = "exec brightnessctl set 10%-";
              XF86MonBrightnessUp = "exec brightnessctl set 10%+";

              # Media key bindings using playerctl
              XF86AudioPlay = "exec --no-startup-id playerctl play-pause";
              XF86AudioNext = "exec --no-startup-id playerctl next";
              XF86AudioPrev = "exec --no-startup-id playerctl previous";
              XF86AudioStop = "exec --no-startup-id playerctl stop";

              "${mod}+Ctrl+space" = "exec --no-startup-id playerctl play-pause";
              "${mod}+Ctrl+Right" = "exec --no-startup-id playerctl next";
              "${mod}+Ctrl+Left" = "exec --no-startup-id playerctl previous";

              "${mod}+Shift+s" = "exec pavucontrol";

              "${mod}+p" = "exec grimshot save active";
              "${mod}+Shift+p" = "exec grimshot save area";
              "${mod}+Ctrl+Shift+p" = "exec grimshot save output";
              "${mod}+Ctrl+p" = "exec grimshot save window";

              # Move workspaces across outputs
              "${mod}+Alt+Left" = "move workspace to output left";
              "${mod}+Alt+Down" = "move workspace to output down";
              "${mod}+Alt+Up" = "move workspace to output up";
              "${mod}+Alt+Right" = "move workspace to output right";
            };
          # bars = [
          #   ({
          #     position = "top";
          #     workspaceButtons = true;
          #     workspaceNumbers = true;
          #     statusCommand = "${pkgs.i3status}/bin/i3status";
          #     trayOutput = "primary";
          #   } // config.stylix.targets.sway.exportedBarConfig)
          # ];
          bars = [ ];
        };
      };
    };
}
