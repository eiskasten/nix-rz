{ ... }:
{
  flake.homeModules.aitMenuModule =
    {
      config,
      lib,
      pkgs,
      ...
    }:

    let
      cfg = config.services.aitMenuWallpaper;

      script = pkgs.writeShellScript "update-ait-menu-wallpaper" ''
        set -u

        out="${cfg.outputPath}"
        new="$out.new"

        mkdir -p "$(${cfg.packages.coreutils}/bin/dirname "$out")"

        if ${cfg.packages.curl}/bin/curl -fL "${cfg.url}" -o "$new"; then
          if [ ! -f "$out" ] || ! ${cfg.packages.coreutils}/bin/cmp -s "$out" "$new"; then
            mv "$new" "$out"

            ${lib.optionalString cfg.imagemagick.enable ''
              ${cfg.packages.imagemagick}/bin/convert \
                ${lib.escapeShellArgs cfg.imagemagick.args} \
                "$out" \
                "${cfg.imagemagick.outputPath}"
            ''}

            ${lib.optionalString cfg.sway.enable ''
              ${cfg.packages.procps}/bin/pkill swaybg || true
            ''}
          else
            rm -f "$new"
          fi
        fi

        ${lib.optionalString cfg.sway.enable ''
          if ${cfg.packages.procps}/bin/pgrep -x swaybg >/dev/null; then
            echo "swaybg still runs"
          else
            echo "swaybg is not running"
            ${cfg.packages.systemd}/bin/systemctl --user restart ${cfg.sway.wallpaperService}
          fi
        ''}
      '';
    in
    {
      options.services.aitMenuWallpaper = {
        enable = lib.mkEnableOption ''
          periodic downloader/updater for a wallpaper or document
          with optional ImageMagick conversion and swaybg integration
        '';

        url = lib.mkOption {
          type = lib.types.str;
          default = "https://menu.mitarbeiterrestaurant.at/menu/techbase-vorschau.pdf";
          example = "https://example.org/wallpaper.pdf";
          description = ''
            URL to download periodically.

            The file is downloaded into `outputPath.new` first and
            replaces the existing file only if contents changed.
          '';
        };

        outputPath = lib.mkOption {
          type = lib.types.str;
          default = "${config.home.homeDirectory}/.local/share/backgrounds/techbase-vorschau.pdf";
          example = "\${config.home.homeDirectory}/wallpapers/menu.pdf";
          description = ''
            Target path of the downloaded file.
          '';
        };

        interval = lib.mkOption {
          type = lib.types.str;
          default = "30min";
          example = "1h";
          description = ''
            systemd timer interval.

            Used as `OnUnitActiveSec`.
          '';
        };

        onBootSec = lib.mkOption {
          type = lib.types.str;
          default = "30s";
          example = "5min";
          description = ''
            Delay after user session startup before the first execution.

            Used as `OnBootSec`.
          '';
        };

        packages = {
          curl = lib.mkOption {
            type = lib.types.package;
            default = pkgs.curl;
            defaultText = lib.literalExpression "pkgs.curl";
            description = ''
              curl package used for downloading the file.
            '';
          };

          coreutils = lib.mkOption {
            type = lib.types.package;
            default = pkgs.coreutils;
            defaultText = lib.literalExpression "pkgs.coreutils";
            description = ''
              coreutils package used for utilities such as
              `dirname` and `cmp`.
            '';
          };

          procps = lib.mkOption {
            type = lib.types.package;
            default = pkgs.procps;
            defaultText = lib.literalExpression "pkgs.procps";
            description = ''
              procps package providing `pgrep` and `pkill`.

              Only required when sway integration is enabled.
            '';
          };

          imagemagick = lib.mkOption {
            type = lib.types.package;
            default = pkgs.imagemagick;
            defaultText = lib.literalExpression "pkgs.imagemagick";
            description = ''
              ImageMagick package providing `convert`.

              Only required when ImageMagick conversion is enabled.
            '';
          };

          systemd = lib.mkOption {
            type = lib.types.package;
            default = pkgs.systemd;
            defaultText = lib.literalExpression "pkgs.systemd";
            description = ''
              systemd package used to invoke `systemctl --user`.
            '';
          };
        };

        imagemagick = {
          enable = lib.mkOption {
            type = lib.types.bool;
            default = true;
            description = ''
              Whether to run ImageMagick conversion after the
              downloaded file changed.
            '';
          };

          args = lib.mkOption {
            type = lib.types.listOf lib.types.str;
            default = [
              "-density"
              "300"
              "-alpha"
              "remove"
            ];
            example = [
              "-density"
              "200"
              "-quality"
              "95"
            ];
            description = ''
              Arguments passed to ImageMagick `convert`.

              The input file is appended automatically, followed by
              `imagemagick.outputPath`.
            '';
          };

          outputPath = lib.mkOption {
            type = lib.types.str;
            default = "${config.home.homeDirectory}/.local/share/backgrounds/techbase-vorschau.png";
            example = "\${config.home.homeDirectory}/wallpapers/menu.png";
            description = ''
              Output path of the converted file.
            '';
          };
        };

        sway = {
          enable = lib.mkOption {
            type = lib.types.bool;
            default = true;
            description = ''
              Whether to integrate with swaybg.

              When enabled:
              - swaybg is terminated after wallpaper changes
              - the configured wallpaper service is restarted if
                swaybg is not running
            '';
          };

          wallpaperService = lib.mkOption {
            type = lib.types.str;
            default = "ait-wallpaper.service";
            example = "sway-wallpaper.service";
            description = ''
              User systemd service restarted when swaybg is not running.
            '';
          };
        };
      };

      config = lib.mkIf cfg.enable {
        systemd.user.services.ait-menu-wallpaper-update = {
          Unit = {
            Description = "Update wallpaper/document from remote source";
          };

          Service = {
            Type = "oneshot";
            ExecStart = "${script}";
          };
        };

        systemd.user.timers.ait-menu-wallpaper-update = {
          Unit = {
            Description = "Periodic wallpaper/document updater";
          };

          Timer = {
            OnBootSec = cfg.onBootSec;
            OnUnitActiveSec = cfg.interval;
            Unit = "ait-menu-wallpaper-update.service";
          };

          Install = {
            WantedBy = [ "timers.target" ];
          };
        };
      };
    };
}
