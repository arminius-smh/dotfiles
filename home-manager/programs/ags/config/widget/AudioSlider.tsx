import Wp from "gi://AstalWp"
import { Gtk } from "astal/gtk3"
import { Variable, bind } from "astal"

export default function AudioSlider() {
    const speaker = Wp.get_default()?.audio.defaultSpeaker!

    let showSlider = Variable(false)

    function volumeAsPercent(vol: number) {
        return `${Math.round(vol * 100)}%`;
    }

    return <eventbox onHover={() => showSlider.set(true)} onHoverLost={() => showSlider.set(false)} onScroll={(_, event) => {
        if (event.delta_y >= 0) {
            speaker.volume = speaker.volume - 0.01 <= 0 ? 0 : speaker.volume - 0.01
        } else {
            speaker.volume = speaker.volume + 0.01 >= 1 ? 1 : speaker.volume + 0.01
        }
    }}>
        <box className="AudioSlider" tooltipText={bind(speaker, "volume").as(vol => volumeAsPercent(vol))} >
            <revealer
                setup={(self) => {
                    showSlider.subscribe((value) => {
                        self.revealChild = value;
                    })
                }}
                transitionType={Gtk.RevealerTransitionType.SLIDE_RIGHT}>
                <slider
                    widthRequest={100}
                    hexpand
                    onDragged={({ value }) => speaker.volume = value}
                    onScroll-Event={(self) => {
                        speaker.volume = self.value
                    }}
                    value={bind(speaker, "volume")}
                />
            </revealer>
            <button onClick="pwvucontrol">
                <label className="volume-icon" label={bind(speaker, "volume_icon").as(vol_icon => {
                    switch (vol_icon) {
                        case 'audio-volume-low-symbolic':
                            return " "
                        case 'audio-volume-medium-symbolic':
                            return " "
                        case 'audio-volume-high-symbolic':
                            return " "
                        case 'audio-volume-muted-symbolic':
                            return " "
                        default:
                            return " "
                    }
                })} />
            </button>
        </box>
    </eventbox >
}

