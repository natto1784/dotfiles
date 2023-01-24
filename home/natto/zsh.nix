{ config, ... }:
let
  secretPath = "${config.home.homeDirectory}/.zshenv_secret";
in
{
  programs.zsh = {
    enable = true;
    autocd = true;
    history = rec {
      expireDuplicatesFirst = true;
      ignoreDups = true;
      size = 30000;
      save = size;
    };
    enableAutosuggestions = true;
    enableCompletion = true;
    enableSyntaxHighlighting = true;
    prezto = {
      enable = true;
      prompt.theme = "pure";
      autosuggestions.color = "fg=yellow,bold";
    };
    initExtra = ''
      . ${secretPath};
      unsetopt extendedGlob
    '';
  };

  age.secrets.zshenv_secret = {
    file = ./secrets/.zshenv_secret;
    path = secretPath;
    mode = "660";
  };
}
