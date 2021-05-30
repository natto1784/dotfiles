{config, ...}:
{
  services = {
    openssh = {
      enable = true;
      permitRootLogin = "yes";
    };
    tailscale.enable = true;
  };
}
