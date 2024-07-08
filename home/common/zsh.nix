{ ... }:
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
    };
    initExtra = ''
      unsetopt extendedGlob
      [[ -f ~/.zsh_custom ]] && source ~/.zsh_custom
    '';
  };
}
