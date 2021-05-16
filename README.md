# Personal Dotfiles

## TODO
1. Add user specific traditional dotfiles.
2. ~~Try home-manager~~
3. ~~Try nix flakes~~

## How install workey
either do
```
git clone https://github.com/natto1784/dotfiles
cd dotfiles
nixos-rebuild switch --flake .#Satori 
```
or 
`nixos-rebuild switch --flake github:natto1784/dotfiles#Satori`\
Replace Satori with whatever system you want or replace to whatever hostname you want in the config

## How home-manager workey
Either clone repo and do `./hm-switch` inside it (login as the user you want to change config as!!!)
or
```
nix build github:natto1784/dotfiles#hm-configs.{USER}.activationPackage -o hm-result
./hm-result/activate
```
You can unlink "hm-result" after that
replace {USER} with 'natto' or whatever is availabe (or change it in the config)

## How packages workey
To build or run any of the packages in this flake do\
`nix <"run"/"build"> github:natto1784/dotfiles#pkgs.<your_arch>.<package_name>`

Following are the people whose configs I took inspiration from and learned stuff from
- [fufexan](https://github.com/fufexan)
- [NobbZ](https://github.com/NobbZ)
- [dramforever](https://github.com/dramforever)

I'm grateful to all of them
