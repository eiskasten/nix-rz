{
  self,
  inputs,
  ...
}:
{
  perSystem =
    { pkgs, ... }:
    {
      packages.nv =
        (self.inputs.nvf.lib.neovimConfiguration {
          inherit pkgs;
          modules = [
            {
              config.vim = {
                autocmds = [
                  {
                    event = [ "FileType" ];
                    pattern = [
                      "json"
                      "jsonc"
                    ];
                    command = "setlocal tabstop=2 shiftwidth=2 softtabstop=2 expandtab";
                    desc = "Use 2-space indent for JSON";
                  }
                ];

                # Enable wayland clipboard
                clipboard = {
                  enable = true;
                  providers.wl-copy.enable = true;
                  registers = "unnamedplus";
                };
                # Enable custom theming options
                theme.enable = true;
                theme.transparent = true;
                theme.name = "dracula";
                theme.style = "dark";

                # Enable Treesitter
                treesitter.enable = true;
                treesitter.context.enable = true;
                treesitter.indent.enable = false;
                autocomplete.nvim-cmp.enable = true;
                comments.comment-nvim.enable = true;

                extraPlugins.nvim-lilypond-suite = {
                  package = pkgs.vimUtils.buildVimPlugin {
                    pname = "nvim-lilypond-suite";
                    version = "unstable";

                    src = pkgs.fetchFromGitHub {
                      owner = "martineausimon";
                      repo = "nvim-lilypond-suite";
                      rev = "master";
                      hash = "sha256-/O2rUPjjcKFl44azZ0SJxzOO9mP5bp3VA+Hgt2/Hxu8=";
                    };

                    nvimRequireCheck = false;
                    doCheck = false;
                  };

                  setup = ''
                    require("nvls").setup({
                      lilypond = {
                        mappings = {
                          player = "<F3>",
                          compile = "<F5>",
                          open_pdf = "<F6>",
                        },
                      },
                    })
                  '';
                };

                # Other options will go here. Refer to the config
                # reference in Appendix B of the nvf manual.
                # ...

                filetree = {
                  neo-tree = {
                    enable = true;
                  };
                };

                git = {
                  enable = true;
                  git-conflict = {
                    enable = true;
                  };
                  gitsigns = {
                    enable = true;
                    setupOpts = {
                      current_line_blame = true;
                      current_line_blame_opts = {
                        delay = 0;
                      };
                    };
                  };
                };

                languages = {
                  enableTreesitter = true;
                  rust = {
                    enable = true;
                  };
                  go = {
                    enable = true;
                  };
                  elixir = {
                    enable = true;
                  };

                  nix = {
                    enable = true;
                  };
                  python = {
                    enable = true;
                  };
                  lua = {
                    enable = true;
                  };

                  markdown = {
                    enable = true;
                    extensions = {
                      markview-nvim.enable = true;
                    };
                    format = {
                      enable = true;
                      type = [ "prettierd" ];
                    };
                  };
                  html = {
                    enable = true;
                  };
                  css = {
                    enable = true;
                  };
                  typst = {
                    enable = true;
                  };
                  terraform.enable = true;
                  yaml.enable = true;
                  json = {
                    enable = true;
                    lsp.enable = true;
                    lsp.servers = [ "jsonls" ];
                  };
                };

                lsp = {
                  enable = true;
                  formatOnSave = true;
                  inlayHints.enable = true;
                  lspSignature.enable = true;
                  trouble.enable = true;

                  servers.jsonls = {
                    enable = true;

                    settings = {
                      json = {
                        format = {
                          enable = true;
                          tabSize = 2; # ← change from 8
                          insertSpaces = true;
                        };
                      };
                    };
                  };
                };

                spellcheck = {
                  enable = true;
                  languages = [
                    "en"
                    "de"
                  ];
                };

                notes.obsidian.enable = false;
              };
            }
          ];
        }).neovim;
    };
}
