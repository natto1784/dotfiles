{ lib, config, pkgs, ... }:

{
  services = {
 /*   openvpn.servers = {
      satori = {
        config = ''
          remote weirdnatto.in
          dev tun
          ifconfig 10.55.0.3 10.55.0.1
          secret /var/secrets/openvpn.key
        '';
      };
    };*/
    vault-agent = {
      enable = false;
      settings = {
        vault = {
          address = "https://10.55.0.2:8800";
          client_cert = "/var/certs/cert.pem";
          client_key = "/var/certs/key.pem";
        };
        auto_auth = {
          method = [
            {
              "cert" = {
                name = "Satori";
              };
            }
          ];
        };
        template = [
          {
            source = pkgs.writeText "openvpn.tpl" ''
              {{ with secret "kv/openvpn" }}{{ .Data.data.secret }}{{ end }}
            '';
            destination = "/var/secrets/openvpn.key";
          }
        ];
      };
    };
    tor.enable = true;
    logmein-hamachi.enable = true;
    openssh = {
      enable = true;
      permitRootLogin = "yes";
    };
    btrfs.autoScrub.enable = true;
    udev.extraRules = ''
      ACTION=="add|change", KERNEL=="sda", ATTR{queue/rotational}=="0", ATTR{queue/scheduler}="bfq"
    '';
    mysql = {
      enable = true;
      package = pkgs.mysql;
    };
  };
  systemd.services = {
    tor.wantedBy = lib.mkForce [ ];
    mysql.wantedBy = lib.mkForce [ ];
    logmein-hamachi.wantedBy = lib.mkForce [ ];
    openssh.wantedBy = lib.mkForce [ ];
    #printing.wantedBy = lib.mkForce [];
    #vault.wantedBy = lib.mkForce [];
  };
  security.pki.certificateFiles = [ ../../cert.pem ];
  /* virtualisation.libvirtd = {
    enable = true;
    onBoot = "ignore";
    onShutdown = "shutdown";
    qemuRunAsRoot = false;
    };*/
}
