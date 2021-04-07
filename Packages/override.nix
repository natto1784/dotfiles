{lib, config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    (callPackage ./customscripts.nix {})
    (callPackage ./mpd_discord_richpresence.nix {})
    (dwm.overrideAttrs (oldAttrs: rec {src = ./dwm;}))
    (st.overrideAttrs (oldAttrs: rec {src = ./st;}))
   (dmenu.overrideAttrs (oldAttrs: rec {
     configFile = writeText "config.def.h" (builtins.readFile ./dmenu/config.def.h);
     postPatch = "${oldAttrs.postPatch}\n cp ${configFile} config.def.h";
    }))
    (kbd.overrideAttrs (oldAttrs: rec{
      buildInputs = oldAttrs.buildInputs ++ [ gzip ];
      colemak-dh = writeText "colemak-dh.map" (builtins.readFile ./colemak-dh.map);
      postInstall = "${oldAttrs.postInstall}\n cp ${colemak-dh} $out/share/keymaps/i386/colemak/colemak-dh.map\n gzip $out/share/keymaps/i386/colemak/colemak-dh.map";
    }))
    (picom.overrideAttrs (oldAttrs: rec{
      version = "Next";
      src = fetchFromGitHub {
        owner = "yshui";
        repo = "picom";
        rev = "v${version}";
        sha256 = "0asp2hg1jx909kl7i876mcx00vwg9w2swr9i6d786iwgs247dc9i";
        fetchSubmodules = true;
      };
    }))
    ncmpcpp
  ];
  nixpkgs.overlays = [
    ( self: super:
    {
      ncmpcpp = super.ncmpcpp.override {
        visualizerSupport = true;
        clockSupport = true;
      };
    }
    )
  ];
}
