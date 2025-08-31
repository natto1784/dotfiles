{ ... }:
{
  programs.gnupg = {
    agent = {
      enableSSHSupport = true;
      enable = true;
    };
  };
}
