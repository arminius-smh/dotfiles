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
            if (!(speaker.volume - 0.01 <= 0)) {
                speaker.volume -= 0.01
            }
        } else {
            if (!(speaker.volume + 0.01 >= 1)) {
                speaker.volume += 0.01

            }
        }
    }}>
        <box className="AudioSlider" >
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
                <box>
                    <icon icon={bind(speaker, "volumeIcon")} />
                    <label className="volume-percent" css={"margin-left: 8px;"}>
                        {bind(speaker, "volume").as(vol => volumeAsPercent(vol))}
                    </label>
                </box>
            </button>
        </box>
    </eventbox >
}

