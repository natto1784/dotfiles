const hyprland = await Service.import("hyprland");

const gurmukhiNums = {
  1: "੧",
  2: "੨",
  3: "੩",
  4: "੪",
  5: "੫",
  6: "੬",
  7: "੭",
  8: "੮",
  9: "੯",
  10: "੦",
};

export default () => {
  const activeId = hyprland.active.workspace.bind("id");
  const workspaces = hyprland.bind("workspaces").as((ws) =>
    ws
      .sort((a, b) => a.id - b.id)
      .map(({ id }) =>
        Widget.Button({
          onClicked: () => hyprland.messageAsync(`dispatch workspace ${id}`),
          child: Widget.Label(gurmukhiNums[id]),
          className: activeId.as(
            (i) => `${i === id ? "focused" : "unfocused"}`,
          ),
          cursor: "pointer",
        }),
      ),
  );

  return Widget.Box({
    css: "padding: 1px;",
    className: "hyprland",
    children: workspaces,
  });
};
