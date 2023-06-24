{ lib, config, pkgs, ... }:
let

udev-cypher = pkgs.stdenv.mkDerivation {
  name = "udev-cypher";

  dontBuild = true;
  dontConfigure = true;
  dontUnpack = true;

  installPhase = ''
    mkdir -p $out/lib/udev/rules.d
    touch $out/lib/udev/rules.d/21-cypherock.rules
cat << 'EOF' >> $out/lib/udev/rules.d/21-cypherock.rules
SUBSYSTEM=="input", GROUP="input", MODE="0666"
SUBSYSTEM=="usb", ATTRS{idVendor}=="3503", ATTRS{idProduct}=="0103", MODE="666", GROUP="plugdev"
KERNEL=="hidraw*", ATTRS{idVendor}=="3503", ATTRS{idProduct}=="0103", MODE="0666", GROUP="plugdev"
0483:374f
SUBSYSTEM=="usb", ATTRS{idVendor}=="0483", ATTRS{idProduct}=="374f", MODE="666", GROUP="plugdev"
KERNEL=="hidraw*", ATTRS{idVendor}=="0483", ATTRS{idProduct}=="374f", MODE="0666", GROUP="plugdev"
EOF
  '';
};
in
{
  services = {
    tor.enable = true;
    openssh = {
      enable = true;
      settings.PermitRootLogin = "yes";
    };
    ratbagd.enable = true;
    btrfs.autoScrub.enable = true;
    udev = {
      packages = [ pkgs.stlink udev-cypher ];
    };
    gvfs.enable = true;
    tlp = {
      enable = true;
      settings = {
        CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
      };
    };
    logind.extraConfig = "RuntimeDirectorySize=30%";
    mysql.enable = true;
    mysql.package = pkgs.mariadb;
  };

  systemd.services = {
    tor.wantedBy = lib.mkForce [ ];
    libvirtd.wantedBy = lib.mkForce [ ];
  };

  security.pki.certificateFiles = [ ../../cert.pem ];
  virtualisation = {
    docker = {
      enable = true;
      enableNvidia = true;
      autoPrune.enable = true;
    };
    libvirtd = {
      enable = true;
      onBoot = "ignore";
      onShutdown = "shutdown";
      qemu.runAsRoot = true;
    };
  };
}
