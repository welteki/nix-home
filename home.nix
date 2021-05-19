{ config, pkgs, ... }:

{
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "han";
  home.homeDirectory = "/users/han";

  programs = {
    git = {
      enable = true;
      userName = "Han Verstraete";
      userEmail = "welteki@pm.me";
    };
    
    zsh = {
      enable = true;
      enableCompletion = true;
      enableAutosuggestions = true;
      initExtra = ''
        if [ -e ~/.nix-profile/etc/profile.d/nix.sh ]; then
          . ~/.nix-profile/etc/profile.d/nix.sh;
          export NIX_PATH=$HOME/.nix-defexpr/channels''${NIX_PATH:+:}$NIX_PATH
        fi # added by Nix installer
        . "$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh"
        '';
    };

    starship = {
      enable = true;
      enableZshIntegration = true;
      settings = {
        docker_context = {
          symbol = " ";
        };
        git_branch = {
          symbol = " ";
        };
        golang = {
          symbol = " ";
        };
        java = {
          symbol = " ";
        };
        kubernetes = {
          symbol = "ﴱ ";
        };
        nix_shell = {
          symbol = " ";
        };
        nodejs = {
          symbol = " ";
        };
        package = {
          symbol = " ";
        };
        python = {
          symbol = " ";
        };
        terraform = {
          symbol = "  ";
        };
      };
    };

    bat.enable = true;
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
