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

  fonts.packages = with pkgs; [
    fira-code
    fira-mono
    monoid
    font-awesome
    material-icons
    material-design-icons
    lohit-fonts.devanagari
    lohit-fonts.gurmukhi
    office-code-pro
    eb-garamond
    noto-fonts-cjk
    takao
    liberation_ttf
  ];

  programs = {
    git.enable = true;

    gnupg = {
      agent = {
        enableSSHSupport = true;
        enable = true;
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
    gamemode.enable = true;
  };
}
