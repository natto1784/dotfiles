{ lib, ... }:
{
  programs.zsh = {
    enable = true;
    autocd = true;
    history = rec {
      expireDuplicatesFirst = true;
      size = 30000;
      save = size;
    };
    autosuggestion.enable = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;
    prezto = {
      enable = true;
      prompt.theme = "pure";
      autosuggestions.color = "fg=yellow,bold";
      utility.safeOps = false;
      extraConfig = lib.mkBefore ''
        export GREP_COLORS="mt=01;31"
      '';
    };
    initContent = lib.mkAfter ''
      unsetopt extendedGlob
      [[ -f ~/.zsh_custom ]] && source ~/.zsh_custom
    '';
  };
}
