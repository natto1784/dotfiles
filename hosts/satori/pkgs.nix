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
    virtmanager
    rnix-lsp
    vulkan-tools
    vulkan-headers
    jq
    dconf
  ];

  programs = {
    gnupg = {
      agent = {
        enableSSHSupport = true;
        enable = true;
        pinentryFlavor = "curses";
      };
    };


    adb.enable = true;
    light.enable = true;
    gamemode.enable = true;
    nm-applet.enable = true;
  };
}
