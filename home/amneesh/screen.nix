{ pkgs, ... }:
{
  home = {
    packages = [ pkgs.screen ];

    file = {
      ".screenrc".text = ''
        defscrollback 10000
      '';
    };
  };
}
