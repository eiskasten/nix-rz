{ ... }:
{
  flake.homeModules.r3sWaybar =
    { ... }:
    {
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
            "sway/scratchpad"
            "custom/media"
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
            all-outputs = true;
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
            interval = 0;
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
                  * {
              /* `otf-font-awesome` is required to be installed for icons */
              font-family: JetBrainsMono Nerd Font;
              font-size: 13px;
          }

          window#waybar {
              background-color: #222222;
              border-bottom: 1px solid rgba(100, 114, 125, 0.5);
              color: #ffffff;
              transition-property: background-color;
              transition-duration: .5s;
          }

          window#waybar.hidden {
              opacity: 0.2;
          }

          /*
          window#waybar.empty {
              background-color: transparent;
          }
          window#waybar.solo {
              background-color: #FFFFFF;
          }
          */

          window#waybar.termite {
              background-color: #3F3F3F;
          }

          window#waybar.chromium {
              background-color: #000000;
              border: none;
          }

          button {
              /* Use box-shadow instead of border so the text isn't offset */
              box-shadow: inset 0 -1px rgba(100, 114, 125, 0.5);
              /* Avoid rounded borders under each button name */
              /* border: solid 1px #ffffff; */
              /* border: none; */
          }

          /* https://github.com/Alexays/Waybar/wiki/FAQ#the-workspace-buttons-have-a-strange-hover-effect */
          button:hover {
              background: inherit;
              /* box-shadow: inset 0 -3px #ffffff; */
          }

          #workspaces button { /*sway: inactive */
              padding: 0 2px;
              background-color: #222222;
              color: #888888;
              border-radius: 0;
              border: solid 1px #333333;
          }

          /* #workspaces button:hover { */
          /*     background: rgba(0, 0, 0, 0.2); */
          /*     background-color: #5F676A; */
          /* } */

          #workspaces button.visible { /*sway: active */
              /*background-color: #285577;*/
              background-color: #5F676A;
              color: #FFFFFF;
              /*border: 1px solid #4C7899;*/
              /*box-sizing: border-box;*/
              box-shadow: inset 0 -1px #333333;
          }

          #workspaces button.focused { /*sway: focused */
              background-color: #285577;
              color: #FFFFFF;
              /*border: 1px solid #4C7899;*/
              /*box-sizing: border-box;*/
              box-shadow: inset 0 -1px #4C7899;
              border-color: #4C7899;
          }

          #workspaces button.urgent {
              background-color: #900000;
              border-color: #2F343A;
              color: #FFFFFF;
          }

          #mode {
              background-color: #64727D;
              border-bottom: 3px solid #ffffff;
          }

          #clock;
          #battery;
          #cpu;
          #memory;
          #disk;
          #temperature;
          #backlight;
          #network;
          #pulseaudio;
          #wireplumber;
          #custom-media;
          #tray;
          #mode;
          #idle_inhibitor;
          #scratchpad;
          #mpd {
              padding: 0 10px;
              color: #ffffff;
          }

          #window;
          #workspaces {
              margin: 0 4px;
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
              /*background-color: #64727D;*/
          }

          #battery {
              /*background-color: #ffffff;
              color: #000000;*/
          }

          #battery.charging, #battery.plugged {
              /*color: #ffffff;
              background-color: #26A65B;*/
          }

          @keyframes blink {
              to {
                  background-color: #ffffff;
                  color: #000000;
              }
          }

          #battery.critical:not(.charging) {
              background-color: #f53c3c;
              color: #ffffff;
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
              /*background-color: #2ecc71;
              color: #000000;*/
          }

          #memory {
              /*background-color: #9b59b6;*/
          }

          #disk {
              /*background-color: #964B00;*/
          }

          #backlight {
              /*background-color: #90b1b1;*/
          }

          #network {
              /*background-color: #2980b9;*/
              color: #00ff00;
          }

          #network.disconnected {
              /*background-color: #f53c3c;*/
              color: #ff0000;
          }

          #pulseaudio {
             /*background-color: #f1c40f;
              color: #000000;*/
          }

          #pulseaudio.muted {
              /*background-color: #90b1b1;
              color: #2a5c45;*/
              color: #f1c40f;
          }

          #wireplumber {
              background-color: #fff0f5;
              color: #000000;
          }

          #wireplumber.muted {
              background-color: #f53c3c;
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
              background-color: #f0932b;
          }

          #temperature.critical {
              background-color: #eb4d4b;
          }

          #tray {
              /*background-color: #2980b9;*/
          }

          #tray > .passive {
              -gtk-icon-effect: dim;
          }

          #tray > .needs-attention {
              -gtk-icon-effect: highlight;
              background-color: #eb4d4b;
          }

          #idle_inhibitor {
              background-color: #2d3436;
          }

          #idle_inhibitor.activated {
              background-color: #ecf0f1;
              color: #2d3436;
          }

          #mpd {
              background-color: #66cc99;
              color: #2a5c45;
          }

          #mpd.disconnected {
              background-color: #f53c3c;
          }

          #mpd.stopped {
              background-color: #90b1b1;
          }

          #mpd.paused {
              background-color: #51a37a;
          }

          #language {
              background: #00b093;
              color: #740864;
              padding: 0 5px;
              margin: 0 5px;
              min-width: 16px;
          }

          #keyboard-state {
              background: #97e1ad;
              color: #000000;
              padding: 0 0px;
              margin: 0 5px;
              min-width: 16px;
          }

          #keyboard-state > label {
              padding: 0 5px;
          }

          #keyboard-state > label.locked {
              background: rgba(0, 0, 0, 0.2);
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
