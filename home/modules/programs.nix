{ pkgs, config, ...}: 
{
  imports = [
    ./programs/nvim.nix
  ];
  programs = {
    firefox = {
      enable = true;
      package = pkgs.firefox-bin;
      profiles.natto = {
        name = "natto";
        userChrome = builtins.readFile ../config/firefox/userChrome.css;
        userContent = builtins.readFile ../config/firefox/userContent.css;
      };
    };
    zathura = {
      enable = true;
      extraConfig = builtins.readFile ../config/zathura/zathurarc;
      options = {
        recolor = true;
        recolor-lightcolor = "rgba(0,0,0,0)";
        default-bg = "rgba(0,0,0,0.7)";
      };
    };
    ncmpcpp = {
      enable = true;
    };
    mpv = {
      enable = true;
      config = {
        force-window = "yes";
        keep-open = "yes";
        save-position-on-quit = "yes";
      };
    };
  };
}
