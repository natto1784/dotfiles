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

    git = {
      enable = true;
      package = pkgs.git.override {
        doInstallCheck = false;
        sendEmailSupport = true;
        withManual = false;
      };
    };

    zsh = {
      enable = true;
      histSize = 30000;
      enableCompletion = true;
      enableBashCompletion = true;
      syntaxHighlighting.enable = true;
      autosuggestions = {
        enable = true;
        highlightStyle = "fg=yellow,bold";
      };
      ohMyZsh.enable = true;
    };
    adb.enable = true;
    light.enable = true;
    /* proxychains = {
      enable = true;
      chain.type = "dynamic";
      proxyDNS = true;
      proxies = {
        remilia = {
          enable = true;
          type = "socks5";
          host = "127.0.0.1";
          port = 2217;
        };
      };
    }; */
    gamemode.enable = true;
    nm-applet.enable = true;
  };
}
