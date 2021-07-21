{config, pkgs, ...}:
{
  imports = 
  [
    ./networking.nix
    ./hardware.nix
    ./boot.nix
    ./services.nix
  ];
  programs.gnupg.agent.enable = pkgs.lib.mkForce false;
  system.stateVersion = "21.05";
}
