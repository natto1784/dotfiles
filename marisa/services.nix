{config, ...}:
{
  services = {
    openssh = {
      enable = true;
      permitRootLogin = "yes";
    };
  };
}
