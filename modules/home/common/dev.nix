{ self, inputs, ... }:
{
  flake.homeModules.dev =
    { pkgs, lib, ... }:
    {
      programs.git = {
        enable = true;
        settings = {
          core = {
            whitespace = "trailing-space,space-before-tab";
          };

          pull.rebase = false;

          init.defaultBranch = "main";
          commit.gpgSign = true;
          log.showSignature = true;
          url = {
            "github:" = {
              insteadOf = "https://github.com/";
            };
          };
        };

        lfs.enable = true;
      };

      programs.bat.enable = true;
      programs.htop.enable = true;
      programs.man.enable = true;

      programs.zsh = {
        enable = true;
        syntaxHighlighting = {
          enable = true;
        };
        enableVteIntegration = true;
        enableCompletion = true;
        initContent = lib.mkOrder 550 ''
          # Note that loading grml's zshrc here will override NixOS settings such as
          # `programs.zsh.histSize`, so they will have to be set again below.
          source ${pkgs.grml-zsh-config}/etc/zsh/zshrc

          alias d='ls -lah'
          alias g=git

          # Increase history size.
          HISTSIZE=10000000

          # Prompt modifications.
          #
          # In current grml zshrc, changing `$PROMPT` no longer works,
          # and `zstyle` is used instead, see:
          # https://unix.stackexchange.com/questions/656152/why-does-setting-prompt-have-no-effect-in-grmls-zshrc

          # Disable the grml `sad-smiley` on the right for exit codes != 0;
          # it makes copy-pasting out terminal output difficult.
          # Done by setting the `items` of the right-side setup to the empty list
          # (as of writing, the default is `items sad-smiley`).
          # See: https://bts.grml.org/grml/issue2267
          zstyle ':prompt:grml:right:setup' items

          # Add nix-shell indicator that makes clear when we're in nix-shell.
          # Set the prompt items to include it in addition to the defaults:
          # Described in: http://bewatermyfriend.org/p/2013/003/
          function nix_shell_prompt () {
            REPLY=''${IN_NIX_SHELL+"(nix-shell) "}
          }
          grml_theme_add_token nix-shell-indicator -f nix_shell_prompt '%F{magenta}' '%f'

          function os_token() {
            if [[ -n "$OS_PROJECT_NAME" ]]; then
              REPLY=`print "%F{red}<%F{yellow}$OS_PROJECT_NAME:$OS_REGION_NAME%F{red}>%f "`
            fi
          }
          grml_theme_add_token openstack -f os_token
          zstyle ':prompt:grml:left:setup' items rc nix-shell-indicator change-root user at host path openstack vcs percent

        '';
        # promptInit = ""; # otherwise it'll override the grml prompt
      };

      home.packages = [
        pkgs.mtr
        pkgs.curl
        pkgs.wireshark
      ];
    };

}
