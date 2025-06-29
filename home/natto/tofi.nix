{
  conf,
  pkgs,
  config,
  ...
}:
{
  home.file.tofi = {
    source = pkgs.writeText "tofi-config" (
      pkgs.lib.generators.toKeyValue { } (
        with conf.colors.default;
        {
          # https://github.com/philj56/tofi/blob/master/themes/fullscreen
          width = "100%";
          height = "100%";
          border-width = 0;
          outline-width = 0;
          padding-left = "35%";
          padding-top = "35%";
          result-spacing = 25;
          num-results = 5;
          font = "Fira Mono";
          font-size = 15;
          text-color = foreground;
          selection-color = rosewater;
          selection-match-color = red;
          background-color = "#000A";
        }
      )
    );
    target = "${config.xdg.configHome}/tofi/config";
  };

  home.packages = with pkgs; [
    tofi
  ];
}
