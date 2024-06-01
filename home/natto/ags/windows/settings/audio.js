const audio = await Service.import("audio");

export default () => {
  const isSpeaker = Variable(true);

  /** @param {'speaker' | 'microphone'} type */
  const VolumeSlider = (type = "speaker") =>
    Widget.Slider({
      hexpand: true,
      drawValue: false,
      onChange: ({ value }) => (audio[type].volume = value),
      value: audio[type].bind("volume"),
    });

  const speakerSlider = VolumeSlider("speaker");
  const micSlider = VolumeSlider("microphone");

  const speakerIndicator = Widget.Button({
    on_clicked: () => (audio.speaker.is_muted = !audio.speaker.is_muted),
    child: Widget.Icon().hook(audio.speaker, (self) => {
      self.className = "volume-icon";
      const vol = audio.speaker.volume * 100;
      let icon = [
        [101, "overamplified"],
        [67, "high"],
        [34, "medium"],
        [1, "low"],
        [0, "muted"],
      ].find(([threshold]) => threshold <= vol)?.[1];

      if (audio.speaker.is_muted) icon = "muted";

      self.icon = `audio-volume-${icon}-symbolic`;
      self.tooltip_text = `Volume ${Math.floor(vol)}%`;
    }),
  });

  const micIndicator = Widget.Button({
    on_clicked: () => (audio.microphone.is_muted = !audio.microphone.is_muted),
    child: Widget.Icon().hook(audio.microphone, (self) => {
      self.className = "volume-icon";
      const vol = audio.microphone.volume * 100;
      let icon = [
        [67, "high"],
        [34, "medium"],
        [1, "low"],
        [0, "muted"],
      ].find(([threshold]) => threshold <= vol)?.[1];

      if (audio.microphone.is_muted) icon = "muted";

      self.icon = `microphone-sensitivity-${icon}-symbolic`;
      self.tooltip_text = `Volume ${Math.floor(vol)}%`;
    }),
  });

  return Widget.EventBox({
    cursor: "pointer",
    className: "volume",
    onSecondaryClick: () => (isSpeaker.value = !isSpeaker.value),
    child: Widget.Stack({
      children: {
        speaker: Widget.Box({}, speakerSlider, speakerIndicator),
        microphone: Widget.Box({}, micSlider, micIndicator),
      },
      shown: isSpeaker.bind().as((s) => (s ? "speaker" : "microphone")),
    }),
  });
};
