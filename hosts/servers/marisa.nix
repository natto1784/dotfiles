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
    ./marisa/cachix.nix
    ../../configs/nvim.nix
  ];
  environment.systemPackages = with pkgs; [
    docker_compose
  ];
  virtualisation.docker.enable = true;
  system.stateVersion = "21.05";
}
