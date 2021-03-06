{ config, pkgs, lib, ... }:
{
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "welteki";
  home.homeDirectory = if pkgs.stdenv.isDarwin then "/Users/welteki" else "/home/welteki";

  home.packages = with pkgs; [] ++ lib.optionals stdenv.isDarwin [
    # Ensure at least bash v4 on macOS for zsh-nix-shell - https://github.com/chisui/zsh-nix-shell/issues/14
    bash
  ];

  programs = {
    git = {
      enable = true;
      userName = "Han Verstraete";
      userEmail = "welteki@pm.me";
      aliases = {
        co = "checkout";
        ci = "commit";
        cia = "commit --amend";
        sci = "commit -S";
        scia = "commit -S --amend";
        st = "status";
        b = "branch";
        pu = "push";
        mff = "merge --ff-only";
        l = "log";
        lo = "log --oneline";
      };
      ignores = [
        # macOS.gitignore source:https://github.com/github/gitignore/blob/master/Global/macOS.gitignore
        # General
        ".DS_Store"
        ".AppleDouble"
        ".LSOverride"

        # Thumbnails
        "._*"
      ];
      extraConfig = {
        init.defaultBranch = "main";
      };
    };
    
    zsh = {
      enable = true;
      enableCompletion = true;
      enableAutosuggestions = true;
      plugins = [
        {
          name = "zsh-syntax-highlighting";
          file = "zsh-syntax-highlighting.plugin.zsh";
          src = pkgs.fetchFromGitHub {
            owner = "zsh-users";
            repo = "zsh-syntax-highlighting";
            rev = "0.7.1";
            sha256 = "03r6hpb5fy4yaakqm3lbf4xcvd408r44jgpv4lnzl9asp4sb9qc0";
          };
        }
      ];
      initExtra = ''
        if [ -e ~/.nix-profile/etc/profile.d/nix.sh ]; then
          . ~/.nix-profile/etc/profile.d/nix.sh;
        fi # added by Nix installer
        export NIX_PATH=$HOME/.nix-defexpr/channels''${NIX_PATH:+:}$NIX_PATH
        '';
    };

    direnv = {
      enable = true;
      nix-direnv.enable = true;
      nix-direnv.enableFlakes = true;
    };

    starship = {
      enable = true;
      enableZshIntegration = true;
      settings = {
        docker_context = {
          symbol = "??? ";
        };
        git_branch = {
          symbol = "??? ";
        };
        golang = {
          symbol = "??? ";
        };
        java = {
          symbol = "??? ";
        };
        kubernetes = {
          symbol = "??? ";
        };
        nix_shell = {
          symbol = "??? ";
        };
        nodejs = {
          symbol = "??? ";
        };
        package = {
          symbol = "??? ";
        };
        python = {
          symbol = "??? ";
        };
        terraform = {
          symbol = "???  ";
        };
      };
    };

    gh.enable = true;
    bat.enable = true;
    jq.enable = true;
    exa = {
      enable = true;
      enableAliases = true;
    };
  };

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "21.05";
}
