import Wp from "gi://AstalWp"
import { Gtk, Gdk } from "astal/gtk3"
import { exec, execAsync, Variable, bind } from "astal"

export default function AudioSlider() {
    const speaker = Wp.get_default()?.audio.defaultSpeaker!

    let homeDir = exec(["bash", "-c", "echo $HOME"]) // howto env var


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
            <button onClick={(_, event) => {
                if (event.button == 1) { // left-click
                    execAsync(["bash", "-c", "pwvucontrol"])
                } else if (event.button == 3) { // right-click
                    speaker.set_mute(!speaker.get_mute())
                }
            }}>
                <icon className="volume-icon" icon={bind(speaker, "volume_icon").as(vol_icon => {
                    switch (vol_icon) {
                        case 'audio-volume-low-symbolic':
                            return `${homeDir}/dotfiles/assets/pics/volume-low.svg`
                        case 'audio-volume-medium-symbolic':
                            return `${homeDir}/dotfiles/assets/pics/volume-medium.svg`
                        case 'audio-volume-high-symbolic':
                            return `${homeDir}/dotfiles/assets/pics/volume-high.svg`
                        case 'audio-volume-overamplified-symbolic':
                            return `${homeDir}/dotfiles/assets/pics/volume-high.svg`
                        case 'audio-volume-muted-symbolic':
                            return `${homeDir}/dotfiles/assets/pics/volume-mute.svg`
                        default:
                            return `${homeDir}/dotfiles/assets/pics/volume-low.svg`
                    }
                })} />
            </button>
        </box>
    </eventbox >
}

