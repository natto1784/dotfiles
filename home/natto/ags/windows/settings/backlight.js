const hasBacklight = Variable(Utils.exec("ls /sys/class/backlight"));

export default () => {
  const getBrightness = () => {
    try {
      return (
        Number(Utils.exec("brightnessctl get")) /
        Number(Utils.exec("brightnessctl max"))
      );
    } catch {
      console.log("settings/backlight: failed to get brightness");
    }
    return 0;
  };

  const setBrightness = (b) => {
    if (b < 0.05) b = 0.05;
    else if (b > 1) b = 1;

    Utils.exec(`brightnessctl set ${b * 100}%`);
  };
  const brightness = Variable(getBrightness());

  const Slider = Widget.Slider({
    hexpand: true,
    drawValue: false,
    onChange: ({ value }) => setBrightness(value),
    value: brightness.bind(),
  });

  const Indicator = Widget.Button({
    on_clicked: brightness.bind().as((b) => () => {
      if (b <= 0.5) brightness.value = 1;
      else brightness.value = 0.5;
    }),
    child: Widget.Icon().hook(brightness, (self) => {
      self.className = "brightness-icon";
      self.icon = `display-brightness-symbolic`;
      self.tooltip_text = `Brightness: ${Math.floor(brightness.value * 100)}%`;
    }),
  });

  return Widget.Box({
    className: "brightness",
    visible: hasBacklight.bind().as((b) => !!b),
    children: [Slider, Indicator],
  });
};
