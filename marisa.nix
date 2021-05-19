{lib, config, ...}:
{
  imports = 
  [
    ./modules/xorg.nix
    ./modules/pipewire.nix
    ./marisa/pkgs.nix
    ./marisa/networking.nix
    ./marisa/stuff.nix
    ./satori/hardware.nix
  ];
  boot.loader.grub.enable = false;
}
