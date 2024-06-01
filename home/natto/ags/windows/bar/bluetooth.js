const bluetooth = await Service.import("bluetooth");

export default () =>
  Widget.Icon({
    setup: (self) =>
      self.hook(
        bluetooth,
        (self) => {
          self.tooltipText = bluetooth.connected_devices
            .map(({ name }) => name)
            .join("\n");
          self.visible = bluetooth.connected_devices.length > 0;
        },
        "notify::connected-devices",
      ),
    icon: bluetooth
      .bind("enabled")
      .as((on) => `bluetooth-${on ? "active" : "disabled"}-symbolic`),
  });
