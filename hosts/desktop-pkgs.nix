{ lib, config, inputs, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    tmux
    bc
    gnumake
    pciutils
    usbutils
    ntfs3g
    python3
    htop
    wget
    ripgrep
    kbd
    gcc
    vulkan-tools
    vulkan-headers
    jq
    dconf
  ];

  programs = {
    git.enable = true;

    gnupg = {
      agent = {
        enableSSHSupport = true;
        enable = true;
      };
    };

    adb.enable = true;
    gamemode.enable = true;
  };
}
