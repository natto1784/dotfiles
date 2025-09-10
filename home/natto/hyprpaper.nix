{
  config,
  ...
}:
{
  services.hyprpaper = {
    enable = true;

    settings =
      let
        wallpaper = "${config.home.homeDirectory}/wallpaper.png";
      in
      {
        preload = [ "${wallpaper}" ];
        wallpaper = [ ", ${wallpaper}" ];
      };
  };
}
