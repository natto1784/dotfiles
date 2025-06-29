{ ... }:
{
  programs = {
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
  };
}

