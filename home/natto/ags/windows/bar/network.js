const network = await Service.import("network");

const WifiIndicator = () =>
  Widget.Box({
    tooltipText: network.wifi.bind("state").as((s) => `State: ${s}`),
    children: [
      Widget.Icon({
        className: "network-icon",
        icon: network.wifi.bind("icon_name"),
      }),
      Widget.Label({
        visible: network.wifi.bind("ssid"),
        label: network.wifi.bind("ssid"),
      }),
    ],
  });

const WiredIndicator = () =>
  Widget.Icon({
    className: "network-icon",
    tooltipText: network.wired.bind("internet").as((a) => `Internet: ${a}`),
    icon: network.wired.bind("icon_name"),
  });

export default () =>
  Widget.Stack({
    className: "network",
    children: {
      wifi: WifiIndicator(),
      wired: WiredIndicator(),
    },
    shown: Utils.merge(
      [network.bind("primary"), network.wired.bind("state")],
      (primary, wired) => {
        if (primary) return primary;
        if (wired == "activated") return "wired";
        return "wifi";
      },
    ),
  });
