{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # Wine and games and stuff
    wineWowPackages.stable
    steam
    winetricks
    # lutris
    # inputs.nix-gaming.packages.${pkgs.system}.osu-lazer-bin
  ];

  programs.mangohud.enable = true;
}

