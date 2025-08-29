{
  ...
}:
{
  services.wayvnc = rec {
    enable = true;
    autoStart = enable;
    settings = {
      address = "0.0.0.0";
      port = 5900;
    };
  };
}
