{ ... }:
{
  security = {
    doas = {
      enable = true;
      extraRules = [
        {
          groups = [ "wheel" ];
          keepEnv = true;
          persist = true;
          setEnv = [ "PATH" ];
        }
      ];
    };
  };
}
