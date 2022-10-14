{ lib, config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    w3m
    tmux
    bc
    ghc
    gnumake
    pciutils
    ntfs3g
    python3
    htop
    nodejs
    wget
    ripgrep
    kbd
    cachix
    gcc
    glibc.static
    stable.openjdk
    virtmanager
    tree-sitter
    docker-compose
    nodePackages.typescript
    rust-bin.nightly.latest.default
    clang-tools
    rnix-lsp
    vulkan-tools
    vulkan-headers
   msr-tools
   steam  
    igrep
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
      package = pkgs.master.git.override {
        sendEmailSupport = true;
        withManual = false;
      };
    };
    zsh = {
      enable = true;
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
          if (( $(echo "$elapsed > 60" | ${pkgs.bc}/bin/bc -l) )) then
            elapsed=$(echo "scale=2; $elapsed/60" | ${pkgs.bc}/bin/bc -l)
            unit="m"
          fi
          RPROMPT='%B%F{cyan}%n%f@%F{red}%m %F{yellow}~%f %F{magenta}$elapsed $unit%f%b '
        fi
        }
      '';
      histSize = 30000;
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
    slock.enable = true;
  };
}
