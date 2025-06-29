{ ... }:
{
  programs = {
    mpv = {
      enable = true;
      config = {
        force-window = true;
        keep-open = true;
        save-position-on-quit = true;
      };
    };
  };
}
