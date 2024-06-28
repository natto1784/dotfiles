{ inputs, globalArgs, ... }:
let
  inherit (inputs) nixpkgs;

  commonModules = [
    ./nvim.nix
    ./nix.nix
    {
      _module.args = globalArgs;
    }
  ];
  desktopModules = [
    ./xorg.nix
    ./wayland.nix
    ./desktop-pkgs.nix
    ./sound.nix
  ];
  serverModules = [ ./minimal.nix ];
in
{
  flake.nixosConfigurations = {
    # Desktop
    okina = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./okina
      ]
      ++ desktopModules
      ++ commonModules;
    };

    #Home laptop
    satori = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./satori
      ]
      ++ desktopModules
      ++ commonModules;
    };

    #Home server (RPi4)
    marisa = nixpkgs.lib.nixosSystem {
      system = "aarch64-linux";
      modules = [
        ./marisa
      ]
      ++ commonModules
      ++ serverModules;
    };

    #Oracle Cloud VM
    remilia = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./remilia
        ./x86builder.nix
        inputs.mailserver.nixosModules.mailserver
      ]
      ++ commonModules
      ++ serverModules;
    };

    #Oracle Cloud VM
    hina = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./hina
        ./x86builder.nix
      ]
      ++ commonModules
      ++ serverModules;
    };
  };
}
