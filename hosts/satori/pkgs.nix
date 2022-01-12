{ lib, config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    w3m
    tmux
    bc
    gnumake
    pciutils
    git
    ntfs3g
    python3
    htop
    nodejs
    ghc
    wget
    ripgrep
    kbd
    cachix
    gcc
    stable.openjdk
    virtmanager
    tree-sitter
    docker-compose
    nodePackages.typescript
    rust-bin.nightly.latest.default
    #language servers
    rust-analyzer
    ccls
    nodePackages.typescript-language-server
    rnix-lsp
    python3Packages.python-lsp-server
    haskell-language-server
    fly
    (steam.override {
      extraLibraries = pkgs: [ pkgs.pipewire ];
      extraProfile = ''
        unset VK_ICD_FILENAMES
        export VK_ICD_FILENAMES=${config.hardware.nvidia.package}/share/vulkan/icd.d/nvidia_icd.json:${config.hardware.nvidia.package.lib32}/share/vulkan/icd.d/nvidia_icd32.json'';
    })
  ];

  programs = {
    gnupg = {
      agent = {
        enableSSHSupport = true;
        enable = true;
        pinentryFlavor = "curses";
      };
    };
    zsh = {
      enable = true;
      shellAliases = {
        "ec" = "emacsclient";
      };
      promptInit = ''
        RPROMPT='%B%F{cyan}%n%f@%F{red}%m%b'
        function preexec() {
          timer=$(date +%s%3N)
        }
        function precmd() {
        if [ $timer ]; then
          now=$(date +%s%3N)
          elapsed=$(($now-$timer))
          unset timer
          unit="ms"
          if [ $elapsed -gt 1000 ]; then
            elapsed=$(echo "scale=1; $elapsed/1000" | ${pkgs.bc}/bin/bc -l)
            unit="s"
          fi
          if (($(echo "$elapsed > 60" | bc -l ))); then
            elapsed=$(echo "scale=2; $elapsed/60" | ${pkgs.bc}/bin/bc -l)
            unit="m"
          fi
          RPROMPT='%B%F{cyan}%n%f@%F{red}%m %F{yellow}~%f %F{magenta}$elapsed $unit%f%b '
        fi
        }
      '';
      histSize = 12000;
      enableCompletion = true;
      enableBashCompletion = true;
      syntaxHighlighting.enable = true;
      autosuggestions = {
        enable = true;
        highlightStyle = "fg=yellow,bold";
      };
      ohMyZsh = {
        enable = true;
        theme = "awesomepanda";
      };
    };
    dconf.enable = true;
    adb.enable = true;
    light.enable = true;
    proxychains = {
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
        remilia4 = {
          enable = true;
          type = "socks4";
          host = "127.0.0.1";
          port = 2217;
        };
      };
    };
  };
  nix = {
    package = pkgs.nixUnstable;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
    trustedUsers = [ "root" "natto" ];
    binaryCaches = [
      "https://nix-gaming.cachix.org"
      "https://nix-community.cachix.org"
      "https://mirrors.tuna.tsinghua.edu.cn/nix-channels/store"
    ];
    binaryCachePublicKeys = [
      "nix-gaming.cachix.org-1:nbjlureqMbRAxR1gJ/f3hxemL9svXaZF/Ees8vCUUs4="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];
  };
}
