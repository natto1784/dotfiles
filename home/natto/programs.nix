{ pkgs, config, conf, ... }:
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
    zathura = {
      enable = true;
      extraConfig = builtins.readFile ./config/zathura/zathurarc;
      options = {
        recolor = true;
        recolor-lightcolor = "rgba(0,0,0,0)";
        default-bg = "rgba(0,0,0,0.8)";
      };
    };

    sioyek = {
      enable = true;
    };

    go.enable = true;
    foot = {
      enable = true;
      settings = {
        main = {
          font = "Fira Mono:style=Regular:pixelsize=18";
          font-bold = "Fira Mono:style=Bold:pixelsize=18";
        };
        scrollback.lines = 4000;
        colors = with conf.colors.default; {
          inherit foreground background;
          regular0 = surface1;
          regular1 = red;
          regular2 = green;
          regular3 = yellow;
          regular4 = blue;
          regular5 = pink;
          regular6 = teal;
          regular7 = subtext1;
          bright0 = surface2;
          bright1 = red;
          bright2 = green;
          bright3 = yellow;
          bright4 = blue;
          bright5 = pink;
          bright6 = teal;
          bright7 = subtext0;
        };
      };
    };
    mpv = {
      enable = true;
      config = {
        force-window = true;
        keep-open = true;
        save-position-on-quit = true;
      };
    };
  };
  home.sessionVariables = {
    BROWSER = "firefox";
  };
}
