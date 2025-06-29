{ config, ... }:
{
  programs = {
    home-manager.enable = true;
    password-store.enable = true;
    direnv.enable = true;
  };
}
