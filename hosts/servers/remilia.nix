{lib, config, ...}:
{
  imports = 
  [
    ./pkgs.nix
    ./stuff.nix
    ./remilia/networking.nix
    ./remilia/hardware.nix
    ./remilia/boot.nix
    ./remilia/services.nix
    ./remilia/builder.nix
    ../../configs/nvim.nix
  ];
 # programs.gnupg.agent.enable = lib.mkForce false;
  system.stateVersion = "21.11";
}
