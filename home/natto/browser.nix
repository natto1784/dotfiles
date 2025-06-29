{ pkgs, ... }:
{
  programs = {
    firefox = {
      enable = true;
      profiles.natto = {
        name = "natto";
      };
    };
    chromium = {
      enable = true;
      package = pkgs.ungoogled-chromium;
    };
  };
  home.sessionVariables = {
    BROWSER = "firefox";
  };
}
