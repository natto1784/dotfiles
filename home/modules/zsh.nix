{ config, ... }:
{
  programs.zsh = {
    enable = true;
    autocd = true;
    history = rec {
      expireDuplicatesFirst = true;
      size = 30000;
      save = size;
    };
    enableAutosuggestions = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;
    prezto = {
      enable = true;
      prompt.theme = "pure";
      autosuggestions.color = "fg=yellow,bold";
      utility.safeOps = false;
    };
    initExtra = ''
      unsetopt extendedGlob
    '';
  };
}
