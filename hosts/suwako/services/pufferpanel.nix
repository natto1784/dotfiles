{ pkgs, lib, ... }:
{
  services.pufferpanel = {
    enable = true;
    extraGroups = [ "docker" ];
    package = pkgs.buildFHSEnv {
      name = "pufferpanel-fhs";
      runScript = lib.getExe pkgs.pufferpanel;
      targetPkgs =
        pkgs': with pkgs'; [
          icu
          openssl
          zlib
        ];
    };
  };
}
