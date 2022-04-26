{ lib, config, agenix, pkgs, ... }:
{
  time.timeZone = "Asia/Kolkata";

  environment = {
    etc."current-system-packages".text =
      let
        packages = builtins.map (p: "${p.name}") config.environment.systemPackages;
        sortedUnique = builtins.sort builtins.lessThan (lib.unique packages);
        formatted = builtins.concatStringsSep "\n" sortedUnique;
      in
      formatted;
    sessionVariables = {
      QT_X11_NO_MITSHM = "1";
      QT_QPA_PLATFORMTHEME = "gtk3";
      HM_CONF_DIR = "/etc/nixos";
    };
    localBinInPath = true;
    shellAliases = rec {
      ec = "emacsclient";
      ecc = ec + " -c";
    };
  };
  security = {
    sudo.enable = true;
    doas = {
      enable = true;
      extraRules = [
        {
          users = [ "natto" ];
          keepEnv = true;
          persist = true;
          setEnv = [ "SSH_AUTH_SOCK" "PATH" "SHELL" "HOME" ];
        }
      ];
    };
  };
  fonts.fonts = with pkgs; [
    fira-mono
    lohit-fonts.devanagari
    lohit-fonts.gurmukhi
    nerdfonts
    font-awesome
    monoid
    office-code-pro
    noto-fonts-cjk
  ];
  users.users.natto = {
    isNormalUser = true;
    shell = pkgs.zsh;
    home = "/home/natto";
    extraGroups = [ "wheel" "adbusers" "video" "libvirtd" "docker" ];
  };
  i18n = {
    inputMethod = {
      #   enabled = "fcitx5";
      #  fcitx5.addons = with pkgs; [ fcitx5-m17n fcitx5-mozc ];
      enabled = "fcitx";
      fcitx.engines = with pkgs.fcitx-engines; [ m17n mozc ];
    };
  };
  virtualisation = {
    docker.enable = true;
    podman = {
      enable = true;
      enableNvidia = true;
    };
  };
  gtk.iconCache.enable = true;
}
