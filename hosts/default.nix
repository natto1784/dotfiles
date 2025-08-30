{ inputs, globalArgs, ... }:
let
  inherit (inputs) nixpkgs;

  commonModules = [
    {
      _module.args = globalArgs;
    }
    ./programs/neovim
    ./programs/nix
    ./programs/zsh
    ./programs/gnupg
    ./programs/git
    ./programs/doas
    ./security
  ];
  desktopModules = [
    ./programs/adb
    ./programs/dconf
    ./services/xserver
    ./services/pipewire
  ];
in
{
  flake.nixosConfigurations = {
    # Desktop
    okina = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules =
        [
          ./okina
        ]
        ++ desktopModules
        ++ commonModules;
    };

    #Home laptop
    satori = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules =
        [
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
      ] ++ commonModules;
    };

    #Oracle Cloud VM
    remilia = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./remilia
        ./x86builder.nix
        inputs.mailserver.nixosModules.mailserver
      ] ++ commonModules;
    };

    #Oracle Cloud VM
    hina = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./hina
        ./x86builder.nix
      ] ++ commonModules;
    };

    #Oracle Cloud VM
    suwako = nixpkgs.lib.nixosSystem {
      system = "aarch64-linux";
      modules = [
        ./suwako
        inputs.mailserver.nixosModules.mailserver
      ] ++ commonModules;
    };
  };
}
