{ pkgs, config, ... }:
{
  programs = {
    firefox = {
      enable = true;
      package = pkgs.master.firefox;
      profiles.natto = {
        name = "natto";
      };
    };
    chromium = {
      enable = true;
      package = pkgs.ungoogled-chromium;
    };
    zathura = {
      enable = true;
      extraConfig = builtins.readFile ./config/zathura/zathurarc;
      options = {
        recolor = true;
        recolor-lightcolor = "rgba(0,0,0,0)";
        default-bg = "rgba(0,0,0,0.8)";
      };
    };
    go.enable = true;
    password-store.enable = true;
    direnv.enable = true;
  };
}
