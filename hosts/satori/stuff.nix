{ lib, config, agenix, pkgs, ... }:
{
  time.timeZone = "Asia/Kolkata";

  environment.localBinInPath = true;

  security = {
    rtkit.enable = true;
    polkit.enable = true;
    sudo.enable = true;
    doas = {
      enable = true;
      extraRules = [
        {
          users = [ "natto" ];
          keepEnv = true;
          persist = true;
          setEnv = [ "SSH_AUTH_SOCK" "PATH" "SHELL" ];
        }
      ];
    };
  };
  console.useXkbConfig = true;

  fonts.fonts = with pkgs; [
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

  users.users.natto = {
    isNormalUser = true;
    shell = pkgs.zsh;
    home = "/home/natto";
    extraGroups = [ "wheel" "adbusers" "video" "libvirtd" "docker" "networkmanager" "dialout" ];
  };

  virtualisation = {
    podman = {
      enable = true;
      enableNvidia = true;
    };
  };

  gtk.iconCache.enable = true;

  # sound stuff
  sound.enable = true;
  services.pipewire = {
    enable = true;
    alsa = {
      enable = true;
      support32Bit = true;
    };
    pulse.enable = true;
    socketActivation = true;
    wireplumber.enable = true;
  };
}
