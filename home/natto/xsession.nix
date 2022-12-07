{ pkgs, config, flake, ... }:
{
  home.pointerCursor = {
    package = flake.packages.${pkgs.system}.simp1e-cursors;
    name = "Simp1e-Solarized-Light";
    x11 = {
      enable = true;
      defaultCursor = "crosshair";
    };
    gtk.enable = true;
  };

  gtk = {
    enable = true;
    theme = {
      package = pkgs.numix-solarized-gtk-theme;
      name = "NumixSolarizedDarkMagenta";
    };
    iconTheme = {
      package = pkgs.zafiro-icons;
      name = "Zafiro-icons-Dark";
    };
  };

  xsession = {
    enable = true;
    windowManager = {
      xmonad = {
        enable = true;
        enableContribAndExtras = true;
        extraPackages = hs: [ hs.xmobar ];
        config = ./config/xmonad/xmonad.hs;
        libFiles = {
          "xmobar.hs" = ./config/xmonad/xmobar.hs;
          "padding-icon.sh" = ./config/xmonad/padding-icon.sh;
          "nixos.xpm" = ./config/xmonad/nixos.xpm;
        };
      };
    };
  };
}
