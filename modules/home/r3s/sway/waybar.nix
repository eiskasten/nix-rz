{ ... }:
{
  flake.homeModules.r3sWaybar =
    { config, lib, ... }:
    let
      base16Names = [
        "base00"
        "base01"
        "base02"
        "base03"
        "base04"
        "base05"
        "base06"
        "base07"
        "base08"
        "base09"
        "base0A"
        "base0B"
        "base0C"
        "base0D"
        "base0E"
        "base0F"
      ];

      colors = lib.genAttrs base16Names (name: config.lib.stylix.colors.${name});
      stylixColorDefs = lib.concatStringsSep "\n" (
        lib.mapAttrsToList (name: value: "@define-color stylix-${name} #${value};") colors
      );
    in
    {
      stylix.targets.waybar.addCss = false;
      programs.waybar = {
        enable = true;
        systemd.enable = true;
        settings.main = {
          layer = "top";
          position = "top";
          height = 8;
          # output = [ "eDP-1" "HDMI-A-1" ];
          modules-left = [
            "sway/workspaces"
            "sway/mode"
            "sway/scratchpad"
            # "custom/media"
          ];
          modules-center = [ ];
          modules-right = [
            "mpris"
            "wireplumber"
            "network#lan"
            "network#usbc"
            "network#wifi"
            "cpu"
            "memory"
            "battery"
            "clock"
            "tray"
          ];

          "sway/workspaces" = {
            disable-scroll = true;
            all-outputs = false;
          };

          mpd = {
            format = "{stateIcon} {consumeIcon}{randomIcon}{repeatIcon}{singleIcon}{artist} - {album} - {title} ({elapsedTime:%M:%S}/{totalTime:%M:%S}) ⸨{songPosition}|{queueLength}⸩ {volume}% ";
            format-disconnected = "Disconnected ";
            format-stopped = "{consumeIcon}{randomIcon}{repeatIcon}{singleIcon}Stopped ";
            unknown-tag = "N/A";
            interval = 2;
            consume-icons = {
              on = " ";
            };
            random-icons = {
              off = "<span color=\"#f53c3c\"></span> ";
              on = " ";
            };
            repeat-icons = {
              on = " ";
            };
            single-icons = {
              on = "1 ";
            };
            state-icons = {
              paused = "";
              playing = "";
            };
            tooltip-format = "MPD (connected)";
            tooltip-format-disconnected = "MPD (disconnected)";
          };
          mpris = {
            artist-len = 20;
            title-len = 40;
            format = "{player}({status}): {title} - {artist}";
          };

          "network#lan" = {
            interface = "enp0s31f6"; # (Optional) To force the use of this interface
            format-wifi = "{essid} ({signalStrength}%) ";
            tooltip-format = "{ifname} via {gwaddr} ";
            format-linked = "{ifname} (No IP) ";
            format-disconnected = "{ifname} (No Link)";
            format-alt = "{ifname}: {ipaddr}/{cidr}";
            format-ethernet = "{ifname}: {ipaddr}/{cidr}";
          };

          "network#usbc" = {
            interface = "eth0"; # (Optional) To force the use of this interface
            format-wifi = "{essid} ({signalStrength}%) ";
            tooltip-format = "{ifname} via {gwaddr} ";
            format-linked = "{ifname} (No IP) ";
            format-disconnected = "{ifname} (No Link)";
            format-alt = "{ifname}: {ipaddr}/{cidr}";
            format-ethernet = "{ifname}: {ipaddr}/{cidr}";
          };

          "network#wifi" = {
            interface = "wlp*"; # (Optional) To force the use of this interface
            format-wifi = "{essid} ({signalStrength}%) ";
            tooltip-format = "{ifname} via {gwaddr} ";
            format-linked = "{ifname} (No IP) ";
            format-disconnected = "{ifname} (No Link)";
            format-alt = "{ifname}: {ipaddr}/{cidr}";
            format-ethernet = "{ifname}: {ipaddr}/{cidr}";
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
          cpu = {
            format = "{usage}% ";
            tooltip = false;
          };
          memory = {
            format = "{used}/{total} ";
          };

          battery = {
            bat = "BAT0";
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
            format = "{:%Y-%m-%d %H:%M}";
            format-alt = "{:%A, %B %d, %Y (%R)}";
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

          tray = {
            # icon-size = 21;
            spacing = 10;
          };
        };

        style = ''
          @define-color bg       #${colors.base00};
          @define-color fg       #${colors.base05};
          @define-color accent   #${colors.base0D};
          @define-color critical #${colors.base08};
          @define-color warn     #${colors.base0A};
          @define-color ok       #${colors.base0C};

          ${stylixColorDefs}

          * {
              /* `otf-font-awesome` is required to be installed for icons */
              font-family: JetBrainsMono Nerd Font;
              font-size: 13px;
          }

          window#waybar {
              background-color: @bg;
              color: @fg;
              border-bottom: 1px solid #${colors.base03};

              transition-property: background-color;
              transition-duration: 0s;
          }

          window#waybar.hidden {
              opacity: 0.2;
          }

          button {
              /* Use box-shadow instead of border so the text isn't offset */
              /* box-shadow: inset 0 -1px rgba(100, 114, 125, 0.5); */
              box-shadow: none;
              /* Avoid rounded borders under each button name */
              /* border: solid 1px #ffffff; */
              /* border: none; */
          }

          /* https://github.com/Alexays/Waybar/wiki/FAQ#the-workspace-buttons-have-a-strange-hover-effect */
          button:hover {
              background: inherit;
          }

          #workspaces button { /*sway: inactive */
              padding: 0 2px;
              background-color: #222222;
              color: #888888;
              border-radius: 0;
              border: solid 1px #333333;
          }

          #workspaces button.visible { /*sway: active */
              background-color: #5F676A;
              color: @fg;
              box-shadow: none;
          }

          #workspaces button.focused { /*sway: focused */
              background-color: #${colors.base0D};
              color: #${colors.base00};
              box-shadow: none;
              border-color: rgba(0, 0, 0, 0.2);
          }

          #workspaces button.urgent {
              background-color: @critical;
              border-color: #2F343A;
              color: #FFFFFF;
          }

          #mode {
              background-color: #64727D;
              border-bottom: 3px solid #ffffff;
          }

          #clock,
          #battery,
          #cpu,
          #memory,
          #disk,
          #temperature,
          #backlight,
          #network,
          #pulseaudio,
          #wireplumber,
          #custom-media,
          #tray,
          #mode,
          #idle_inhibitor,
          #scratchpad,
          #mpd {
              padding: 0 10px;
          }

          #window,
          #workspaces {
              margin: 0 4px;
          }

          .modules-left,
          .modules-center,
          .modules-right {
              color: @fg;
          }

          /* If workspaces is the leftmost module, omit left margin */
          .modules-left > widget:first-child > #workspaces {
              margin-left: 0;
          }

          /* If workspaces is the rightmost module, omit right margin */
          .modules-right > widget:last-child > #workspaces {
              margin-right: 0;
          }

          #clock {
          }

          #battery {
          }

          #battery.charging, #battery.plugged {
          }

          @keyframes blink {
              to {
                  background-color: #ffffff;
                  color: #000000;
              }
          }

          #battery.critical:not(.charging) {
              background-color: #${colors.base08};
              color: #${colors.base00};
              animation-name: blink;
              animation-duration: 0.5s;
              animation-timing-function: linear;
              animation-iteration-count: infinite;
              animation-direction: alternate;
          }

          label:focus {
              background-color: #000000;
          }

          #cpu {
          }

          #memory {
          }

          #disk {
          }

          #backlight {
          }

          #network {
              color: @ok;
          }

          #network.disconnected {
              color: @fg;
          }

          #pulseaudio {
          }

          #pulseaudio.muted {
              color: @warn;
          }

          #wireplumber {
          }

          #wireplumber.muted {
              color: @warn;
          }

          #custom-media {
              background-color: #66cc99;
              color: #2a5c45;
              min-width: 100px;
          }

          #custom-media.custom-spotify {
              background-color: #66cc99;
          }

          #custom-media.custom-vlc {
              background-color: #ffa000;
          }

          #temperature {
          }

          #temperature.critical {
              color: @critical;
          }

          #tray {
          }

          #tray > .passive {
              -gtk-icon-effect: dim;
          }

          #tray > .needs-attention {
              -gtk-icon-effect: highlight;
              background-color: @critical;
          }

          #idle_inhibitor {
              background-color: #2d3436;
          }

          #idle_inhibitor.activated {
          }

          #mpd {
          }

          #mpd.disconnected {
          }

          #mpd.stopped {
          }

          #mpd.paused {
          }

          #language {
          }

          #keyboard-state {
          }

          #keyboard-state > label {
          }

          #keyboard-state > label.locked {
          }

          #scratchpad {
              background: rgba(0, 0, 0, 0.2);
          }

          #scratchpad.empty {
          	background-color: transparent;
          }
        '';
      };

    };
}
