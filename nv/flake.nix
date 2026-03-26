{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nvf.url = "github:notashelf/nvf";
  };

  outputs =
    { nixpkgs, ... }@inputs:
    {
      packages.x86_64-linux = {
        # Set the default package to the wrapped instance of Neovim.
        # This will allow running your Neovim configuration with
        # `nix run` and in addition, sharing your configuration with
        # other users in case your repository is public.
        default =
          (inputs.nvf.lib.neovimConfiguration {
            pkgs = nixpkgs.legacyPackages.x86_64-linux;
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
                  autocomplete.nvim-cmp.enable = true;
                  comments.comment-nvim.enable = true;

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
                    };
                    html = {
                      enable = true;
                    };
                    typst.enable = true;

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
    };
}
