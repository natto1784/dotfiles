{ ... }:
{
  programs.zsh = {
    enable = true;
    histSize = 30000;
    enableBashCompletion = true;
    enableCompletion = true;
    autosuggestions = {
      enable = true;
      highlightStyle = "fg=yellow,bold";
    };
  };
}
