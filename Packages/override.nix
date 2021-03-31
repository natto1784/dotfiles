{lib, config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    (callPackage ./customscripts.nix {})
    (callPackage ./mpd_discord_richpresence.nix {})
    (dwm.overrideAttrs (oldAttrs: rec {
      src = fetchFromGitHub {
        owner = "idcretard";
        repo = "dwm";
        rev = "363951cb05142f4c423af561a05658e74be7c768";
        sha256 ="003sl6w5dkycw8wcymvhi843xjngsys6qsl3fc5b9vpyd1l7i0sr";
      };
    }))
    (st.overrideAttrs (oldAttrs: rec {
      src = fetchFromGitHub {
        owner = "idcretard";
        repo = "st";
        rev = "0cd1e394e6d07c5f605ae23070c40de9690bafb1";
        sha256 = "0riqg63aghx71v3rrpic3mxhcxqhry20312bicwbf3ks7ndl13hi";
      };
    }))
   (dmenu.overrideAttrs (oldAttrs: rec {
     configFile = writeText "config.def.h" (builtins.readFile ./dmenu/config.def.h);
     postPatch = "${oldAttrs.postPatch}\n cp ${configFile} config.def.h";
    }))
    (kbd.overrideAttrs (oldAttrs: rec{
      buildInputs = oldAttrs.buildInputs ++ [ gzip ];
      colemak-dh = writeText "colemak-dh.map" (builtins.readFile ./colemak-dh.map);
      postInstall = "${oldAttrs.postInstall}\n cp ${colemak-dh} $out/share/keymaps/i386/colemak/colemak-dh.map\n gzip $out/share/keymaps/i386/colemak/colemak-dh.map";
    }))
    (ncmpcpp.overrideAttrs (_ :{
      visualizerSupport = true;
      clockSupport = true;
    }))
  ];
}
