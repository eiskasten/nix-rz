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

      programs.foot.enable = true;

      # stylix.targets.waybar.font = "emoji";

      wayland.windowManager.sway.checkConfig = false; # required since xkb_layout is registered system-wide which home-manager is not aware of ;(
      wayland.windowManager.sway = {
        enable = true;
        wrapperFeatures.gtk = true;
        systemd.enable = true;
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

              "${mod}+d" = "exec rofi -show drun";
              "${mod}+Shift+w" = "exec rofi -show window";

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
