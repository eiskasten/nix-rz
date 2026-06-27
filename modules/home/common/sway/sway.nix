{ self, inputs, ... }:
{
  flake.homeModules.sway =
    {
      config,
      pkgs,
      lib,
      inputs,
      ...
    }:
    let
      rofiExe = "rofi";
    in
    {

      home.packages = [
        pkgs.sway-contrib.grimshot
        pkgs.wl-clipboard

        pkgs.swaybg

        pkgs.font-awesome

        pkgs.grim # screenshot functionality
        pkgs.slurp # screenshot functionality
        pkgs.zbar # scan qr-codes
      ];

      programs.foot = {
        enable = true;
        settings = {
          colors-dark.alpha = lib.mkForce 0.9;
        };
      };
      programs.swaylock.enable = true;
      services.wl-clip-persist.enable = true;

      wayland.windowManager.sway.checkConfig = false; # required since xkb_layout is registered system-wide which home-manager is not aware of ;(
      wayland.windowManager.sway = {
        enable = true;
        wrapperFeatures.gtk = true;
        systemd = {
          enable = true;
          xdgAutostart = true;
        };
        config = {
          input = {
            "*" = {
              xkb_layout = "kdf";
              xkb_options = "srvrkeys:none";
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

              "${mod}+d" = "exec ${rofiExe} -show drun";
              "${mod}+Shift+w" = "exec ${rofiExe} -show window";
              "${mod}+Shift+f" = "exec ${rofiExe} -show filebrowser";

              "${mod}+Shift+n" = "exec ${lib.getExe pkgs.rofi-network-manager}";
              "${mod}+Shift+v" = "exec ${lib.getExe pkgs.rofi-vpn}";
              "${mod}+Shift+b" = "exec ${lib.getExe pkgs.rofi-bluetooth}";

              "${mod}+p" = "exec grimshot savecopy active";
              "${mod}+Shift+p" = "exec grimshot savecopy area";
              "${mod}+Ctrl+Shift+p" = "exec grimshot savecopy output";
              "${mod}+Ctrl+p" = "exec grimshot savecopy window";

              # Scan qr-codes
              "${mod}+q" = ''exec grim -g "$(slurp)" - | zbarimg --quiet --raw - | wl-copy'';

              # Move workspaces across outputs
              "${mod}+Alt+Left" = "move workspace to output left";
              "${mod}+Alt+Down" = "move workspace to output down";
              "${mod}+Alt+Up" = "move workspace to output up";
              "${mod}+Alt+Right" = "move workspace to output right";

              # Lock the screen
              "${mod}+l" = "exec swaylock";
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
