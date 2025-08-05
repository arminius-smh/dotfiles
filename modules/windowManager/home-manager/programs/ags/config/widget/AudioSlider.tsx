import Wp from "gi://AstalWp"
import { Astal, Gtk, Gdk } from "ags/gtk4"
import { For, Accessor, createState, createBinding } from "ags"
import GLib from "gi://GLib"
import Popover from "./Popover"

const HOME = GLib.getenv("HOME") ?? ''

function getIcon(name: string) {
    if (lookupIcon(name)) {
        return name
    } else if (lookupIcon(name.toLowerCase()))
        return name.toLowerCase()
    else {
        return 'application-x-executable-symbolic'
    }
}

function lookupIcon(name: string) {
    return Gtk.IconTheme.get_for_display(Gdk.Display.get_default()!)?.has_icon(name)
}

function getVolumeIcon(vol_icon: string) {
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
}

export default function AudioSlider() {
    const speaker = Wp.get_default()?.audio.defaultSpeaker!


    let [showSlider, setshowSlider] = createState(false)

    function volumeAsPercent(vol: number) {
        return `${Math.round(vol * 100)}%`;
    }

    let streams = createBinding(Wp.get_default()!.audio, "streams")

    const { TOP, RIGHT } = Astal.WindowAnchor
    const [visible1, setvisible1] = createState(false);

    <Popover
        visible={visible1}
        setvisible={setvisible1}
        marginTop={5}
        marginRight={165}
        anchor={TOP | RIGHT}
    >
        <box class="AudioStreamsPopup" orientation={Gtk.Orientation.VERTICAL}>
            <label label="Playback" css={'font-weight: bold;'} />
            <label class="horziontalLine" css={'margin-bottom: 10px; border-color: #cba6f7;'} />
            <For each={streams}>
                {(stream) => {
                    return <box class="AudioStream" orientation={Gtk.Orientation.VERTICAL}>
                        <box
                            $={(self) => {
                                const clickController = new Gtk.GestureClick();
                                clickController.set_button(0)
                                clickController.connect('pressed', (_controller) => {
                                    const button = _controller.get_current_button();
                                    if (button === 1) { // 1 = left click
                                        stream.set_mute(!stream.get_mute())
                                    }
                                    if (button === 3) { // 3 = right click
                                        stream.set_mute(!stream.get_mute())
                                    }

                                    // not sure why this is needed, otherwise left clicks only work once
                                    _controller.reset()
                                });
                                self.add_controller(clickController);
                            }}
                        >
                            <image iconName={createBinding(stream, "description").as(desc => getIcon(desc))} />
                            <label label={createBinding(stream, "description").as(str => str.charAt(0).toUpperCase() + str.slice(1))} css={createBinding(stream, "mute").as((val) => val ? "color: #6c7086; text-decoration: line-through;" : "")}
                            />
                        </box>
                        <slider
                            tooltipText={createBinding(stream, "volume").as(vol => volumeAsPercent(vol))}
                            widthRequest={150}
                            onChangeValue={({ value }) => { stream.volume = value }}
                            value={createBinding(stream, "volume")}
                        />
                    </box>
                }}
            </For>
        </box>
    </Popover>

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
                            setvisible1(true)
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
                <image class="volume-icon" pixelSize={20} file={createBinding(speaker, "volume_icon").as(vol_icon => getVolumeIcon(vol_icon))} />
            </button>
        </box>
    </box >
}

