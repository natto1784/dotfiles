{lib, config, ...}:
{
  imports = 
  [
    ./pkgs.nix
    ./stuff.nix
    ./marisa/networking.nix
    ./marisa/hardware.nix
    ./marisa/boot.nix
    ./marisa/services.nix
    ./marisa/cachix.nix
    ../../configs/nvim.nix
  ];
  system.stateVersion = "21.05";
}
