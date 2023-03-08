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
    git.enable = true;

    gnupg = {
      agent = {
        enableSSHSupport = true;
        enable = true;
        pinentryFlavor = "curses";
      };
    };

    zsh = {
      enable = true;
      histSize = 30000;
      enableBashCompletion = true;
      enableCompletion = true;
      autosuggestions = {
        enable = true;
        highlightStyle = "fg=yellow,bold";
      };
    };


    adb.enable = true;
    light.enable = true;
    gamemode.enable = true;
  };
}
