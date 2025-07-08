import { Astal, Gtk } from "ags/gtk4"
import Mpris from "gi://AstalMpris"
import Popover from "./Popover"
import { Setter, With, createBinding, createState } from "ags"
import { exec } from "ags/process"

const { TOP, LEFT } = Astal.WindowAnchor
let hostname = exec(["bash", "-c", "hostname"])

function lengthStr(length: number) {
    const min = Math.floor(length / 60)
    const sec = Math.floor(length % 60)
    const sec0 = sec < 10 ? "0" : ""
    return `${min}:${sec0}${sec}`
}

function MediaPlayer({ player }: { player: Mpris.Player }) {
    const title_short = createBinding(player, "title").as(t => {
        if (t.length > 38) {
            t = t.substring(0, 35) + "...";
        }
        return t || "Unknown Track"
    })

    const title_full = createBinding(player, "title").as(t => {
        return t || "Unknown Track"
    })

    const artist = createBinding(player, "artist").as(a =>
        a || "Unknown Artist")

    const coverArt = createBinding(player, "coverArt").as(c => `background-image: url("file://${c}");`)

    const playerIcon = createBinding(player, "entry").as(e =>
        e != null ? e : "audio-x-generic-symbolic")

    const playIcon = createBinding(player, "playbackStatus").as(s =>
        s === Mpris.PlaybackStatus.PLAYING
            ? "󰏤"
            : "󰐊"
    )

    const position = createBinding(player, "position").as(p => player.length > 0
        ? p / player.length : 0)

    let [showSlider, setshowSlider] = createState(false)

    const [visible1, setvisible1] = createState(false);

    <Popover
        anchor={hostname === "discovery" ? TOP | LEFT : TOP}
        marginTop={10}
        marginLeft={hostname === "discovery" ? 30 : 0}
        visible={visible1}
        setvisible={setvisible1}
    >
        <box class="MediaPlayerPopup">
            <box class="cover-art" css={coverArt} />
            <box orientation={Gtk.Orientation.VERTICAL}>
                <box class="title" tooltipText={title_full}>
                    <label hexpand halign={Gtk.Align.CENTER} label={title_short} />
                </box>
                <label class="artist" halign={Gtk.Align.CENTER} valign={Gtk.Align.START} vexpand wrap label={artist} />

                <box class="actionButtons" halign={Gtk.Align.CENTER}>
                    <button
                        onClicked={() => player.previous()}
                        visible={createBinding(player, "canGoPrevious")}>
                        <label label="󰒮" />
                    </button>
                    <button
                        onClicked={() => player.play_pause()}
                        visible={createBinding(player, "canControl")}>
                        <label label={playIcon} />
                    </button>
                    <button
                        onClicked={() => player.next()}
                        visible={createBinding(player, "canGoNext")}>
                        <label label="󰒭" />
                    </button>
                </box>
                <box class="timer">
                    <label
                        class="position"
                        hexpand
                        halign={Gtk.Align.START}
                        visible={createBinding(player, "length").as(l => l > 0)}
                        label={createBinding(player, "position").as(lengthStr)}
                    />
                    <label
                        class="length"
                        hexpand
                        halign={Gtk.Align.END}
                        visible={createBinding(player, "length").as(l => l > 0)}
                        label={createBinding(player, "length").as(l => l > 0 ? lengthStr(l) : "0:00")}
                    />
                </box>
                <slider
                    visible={createBinding(player, "length").as(l => l > 0)}
                    onChangeValue={({ value }) => { player.position = value * player.length }}
                    value={position}
                />
            </box>
        </box>
    </Popover>

    return <box class="MediaPlayer" tooltipText={title_full}
        $={(self) => {
            const keyController = new Gtk.EventControllerMotion();

            keyController.connect('enter', () => {
                setshowSlider(true)
            })
            keyController.connect('leave', () => {
                setshowSlider(false)
            })

            self.add_controller(keyController)
        }}
    >
        <box
            $={(self) => {
                const clickController = new Gtk.GestureClick();
                clickController.set_button(0)

                clickController.connect('pressed', (_controller) => {
                    const button = _controller.get_current_button();
                    if (button === 1) { // 1 = left click
                        setvisible1(true)
                    }

                    // not sure why this is needed, otherwise left clicks only work once
                    _controller.reset()
                });
                self.add_controller(clickController)
            }}
        >
            <box class="cover-art" css={coverArt} />
            <box class="title">
                <label label={title_short} />
                <image iconName={playerIcon} />
            </box>
        </box>

        <revealer
            revealChild={showSlider}
            transitionType={Gtk.RevealerTransitionType.SLIDE_LEFT}>
            <box class="controller">
                <button
                    onClicked={() => player.previous()}
                    visible={createBinding(player, "canGoPrevious")}>
                    <label label="󰒮" />
                </button>
                <button
                    onClicked={() => player.play_pause()}
                    visible={createBinding(player, "canControl")}>
                    <label label={playIcon} />
                </button>
                <button
                    onClicked={() => player.next()}
                    visible={createBinding(player, "canGoNext")}>
                    <label label="󰒭" />
                </button>
            </box>
        </revealer>
    </box>
}

function playerSetup(player: Mpris.Player, setShowPlayer: Setter<Mpris.Player>, players: Array<Mpris.Player>) {
    createBinding(player, "available").subscribe(() => {
        if (player.get_available() === true) {
            setShowPlayer(player)
        } else {
            setShowPlayer(players.filter((val) => (val.get_bus_name() != player.get_bus_name())).at(0) ?? Mpris.Player.new("none"))
        }
    })
    createBinding(player, "playbackStatus").subscribe(() => {
        if (player.get_playback_status() === Mpris.PlaybackStatus.PLAYING) {
            setShowPlayer(player)
        }
    })

    if (player.get_available() === true) {
        setShowPlayer(player)
    }

    if (player.get_playback_status() === Mpris.PlaybackStatus.PLAYING) {
        setShowPlayer(player)
    }
}

export default function MprisPlayers() {
    const [showPlayer, setShowPlayer] = createState(Mpris.Player.new("none"))

    const players = [
        Mpris.Player.new("spotify"),
        Mpris.Player.new("spotify_player"),
    ]

    players.forEach(player => {
        playerSetup(player, setShowPlayer, players)
    });

    return <box>
        <With value={showPlayer}>
            {(player) => {
                if (player.available) {
                    return <revealer $={(self) => setTimeout(() => self.revealChild = true, 100)} transitionType={Gtk.RevealerTransitionType.CROSSFADE}>
                        <MediaPlayer player={player} />
                    </revealer>
                } else {
                    return <box />
                }
            }}
        </With>
    </box>
}
