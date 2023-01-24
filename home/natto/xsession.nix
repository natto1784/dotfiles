{ pkgs, config, flake, ... }:
{
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

  home.packages = with pkgs; [
    (dmenu.override { patches = [ ./patches/dmenu.patch ]; })
    (st.override {
      patches = [ ./patches/st.patch ];
      extraLibs = [ harfbuzz ];
    })
    xclip
    xorg.xkbcomp
    xorg.xmodmap
    sxiv
    xdotool
    (xfce.thunar.override {
      thunarPlugins = with xfce; [
        thunar-media-tags-plugin
        thunar-volman
        thunar-archive-plugin
      ];
    })
    xfce.xfconf
    xfce.tumbler
    flameshot
    xmobar
    stalonetray
  ];

  home.file.stalonetray = {
    source = ./config/stalonetrayrc;
    target = "${config.home.homeDirectory}/.stalonetrayrc";
  };
}
