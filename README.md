# Personal Dotfiles

## TODO
1. Add user specific traditional dotfiles.
2. Try home-manager for nix (Trying out right now)
3. ~~Try nix flakes~~

## How install workey
```
git clone https://github.com/natto1784/dotfiles
cd dotfiles
nixos-rebuild switch --flake .
```

## How home-manager workey
Either clone repo and do `./hm-switch` inside it (ofc change the username in the flake to yours dum dum)\
or
```
nix build github:natto1784/dotfiles#hm-configs.{USER}.activationPackage -o allah
./allah/activate
```
You can unlink allah afterwards
(replace {USER} with 'natto' or whatever username there is in flake.nix, retard)
