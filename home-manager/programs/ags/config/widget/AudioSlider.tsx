import Wp from "gi://AstalWp"
import { Gtk } from "ags/gtk4"
import { execAsync } from "ags/process"
import { createState, createBinding } from "ags"
import GLib from "gi://GLib"

export default function AudioSlider() {
    const speaker = Wp.get_default()?.audio.defaultSpeaker!

    const HOME = GLib.getenv("HOME")


    let [showSlider, setshowSlider] = createState(false)

    function volumeAsPercent(vol: number) {
        return `${Math.round(vol * 100)}%`;
    }

    return <box
        $={(self) => {
            const keyController = new Gtk.EventControllerMotion();
            const scrollController = new Gtk.EventControllerScroll();

            scrollController.set_flags(Gtk.EventControllerScrollFlags.VERTICAL);

            keyController.connect('enter', () => {
                setshowSlider(true)
            })
            keyController.connect('leave', () => {
                setshowSlider(false)
            })

            scrollController.connect('scroll', (_controller, _, dy) => {
                if (dy >= 0) { // scroll-down
                    speaker.volume = speaker.volume - 0.01 <= 0 ? 0 : speaker.volume - 0.01
                } else {
                    speaker.volume = speaker.volume + 0.01 >= 1 ? 1 : speaker.volume + 0.01
                }
            });

            self.add_controller(keyController)
            self.add_controller(scrollController)
        }}
    >
        <box class="AudioSlider" tooltipText={createBinding(speaker, "volume").as(vol => volumeAsPercent(vol))} >
            <revealer
                revealChild={showSlider}
                transitionType={Gtk.RevealerTransitionType.SLIDE_RIGHT}>
                <label label="heeey" />
                <slider
                    widthRequest={100}
                    onChangeValue={({ value }) => { speaker.volume = value }}
                    value={createBinding(speaker, "volume")}
                />
            </revealer>
            <button
                $={(self) => {
                    const clickController = new Gtk.GestureClick();
                    clickController.set_button(0)
                    clickController.connect('pressed', (_controller) => {
                        const button = _controller.get_current_button();
                        if (button === 1) { // 1 = left click
                            execAsync(["bash", "-c", "pwvucontrol"])
                        }
                        if (button === 3) { // 3 = right click
                            speaker.set_mute(!speaker.get_mute())
                        }

                        // not sure why this is needed, otherwise left clicks only work once
                        _controller.reset()
                    });
                    self.add_controller(clickController);
                }}
            >
                <image class="volume-icon" pixelSize={20} file={createBinding(speaker, "volume_icon").as(vol_icon => {
                    switch (vol_icon) {
                        case 'audio-volume-low-symbolic':
                            return `${HOME}/dotfiles/assets/pics/volume-low.svg`
                        case 'audio-volume-medium-symbolic':
                            return `${HOME}/dotfiles/assets/pics/volume-medium.svg`
                        case 'audio-volume-high-symbolic':
                            return `${HOME}/dotfiles/assets/pics/volume-high.svg`
                        case 'audio-volume-overamplified-symbolic':
                            return `${HOME}/dotfiles/assets/pics/volume-high.svg`
                        case 'audio-volume-muted-symbolic':
                            return `${HOME}/dotfiles/assets/pics/volume-mute.svg`
                        default:
                            return `${HOME}/dotfiles/assets/pics/volume-low.svg`
                    }
                })} />
            </button>
        </box>
    </box >
}

