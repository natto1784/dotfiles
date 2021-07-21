{config, pkgs, ...}:
{
  imports = 
  [
    ./pkgs.nix
    ./stuff.nix
    ./marisa/networking.nix
    ./marisa/hardware.nix
    ./marisa/boot.nix
    ./marisa/services.nix
    ./marisa/builder.nix
    ../../configs/nvim.nix
  ];
  programs.gnupg.agent.enable = pkgs.lib.mkForce false;
  system.stateVersion = "21.05";
}
