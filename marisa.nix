{lib, config, ...}:
{
  imports = 
  [
 #   <nixpkgs/nixos/modules/profiles/all-hardware.nix>
    ./marisa/pkgs.nix
    ./marisa/networking.nix
    ./marisa/stuff.nix
    ./marisa/hardware.nix
    ./marisa/boot.nix
    ./marisa/services.nix
  ];
  system.stateVersion = "21.05";
}
