import { WindowNames } from "../../constants.js";

export default (monitor) =>
  Widget.Button({
    child: Widget.Icon("open-menu-symbolic"),
    onPrimaryClick: () =>
      App.toggleWindow(`${WindowNames.SETTINGS}-${monitor}`),
  });
