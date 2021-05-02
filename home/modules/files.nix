{config, ...}:
let
  home = config.home.homeDirectory;
in {
  home = {
    file.ncmpcpp = {
      source = ../config/ncmpcpp/config;
      target = "${home}/.config/ncmpcpp/config";
    };
    file.mpd = {
      source = ../config/mpd/mpd.conf;
      target = "${home}/.config/mpd/mpd.conf";
    };
  };
}
