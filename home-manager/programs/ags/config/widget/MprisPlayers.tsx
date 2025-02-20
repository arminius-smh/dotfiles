import { Astal, Gtk } from "astal/gtk3"
import Mpris from "gi://AstalMpris"
import { Variable, bind } from "astal"
import Popover from "./Popover"


function lengthStr(length: number) {
    const min = Math.floor(length / 60)
    const sec = Math.floor(length % 60)
    const sec0 = sec < 10 ? "0" : ""
    return `${min}:${sec0}${sec}`
}

function MediaPlayer({ player }: { player: Mpris.Player }) {
    const title_short = bind(player, "title").as(t => {
        if (t.length > 38) {
            t = t.substring(0, 35) + "...";
        }
        return t || "Unknown Track"
    })

    const title_full = bind(player, "title").as(t => {
        return t || "Unknown Track"
    })

    const artist = bind(player, "artist").as(a =>
        a || "Unknown Artist")

    const coverArt = bind(player, "coverArt").as(c =>
        `background-image: url('${c}')`)

    const playerIcon = bind(player, "entry").as(e =>
        e != null && Astal.Icon.lookup_icon(e) ? e : "audio-x-generic-symbolic")

    const playIcon = bind(player, "playbackStatus").as(s =>
        s === Mpris.PlaybackStatus.PLAYING
            ? "󰏤"
            : "󰐊"
    )

    const position = bind(player, "position").as(p => player.length > 0
        ? p / player.length : 0)

    let showSlider = Variable(false)

    const visible1 = Variable(false);

    const _popover1 = <Popover
        onClose={() => visible1.set(false)}
        visible={visible1()}
        marginTop={50}
        valign={Gtk.Align.START}
        halign={Gtk.Align.CENTER}
    >
        <box className="MediaPlayerPopup">
            <box className="cover-art" css={coverArt} />
            <box vertical>
                <box className="title" tooltipText={title_full}>
                    <label truncate hexpand halign={Gtk.Align.CENTER} label={title_short} />
                </box>
                <label className="artist" halign={Gtk.Align.CENTER} valign={Gtk.Align.START} vexpand wrap label={artist} />

                <box className="actionButtons" halign={Gtk.Align.CENTER}>
                    <button
                        onClicked={() => player.previous()}
                        visible={bind(player, "canGoPrevious")}>
                        <label label="󰒮" />
                    </button>
                    <button
                        onClicked={() => player.play_pause()}
                        visible={bind(player, "canControl")}>
                        <label label={playIcon} />
                    </button>
                    <button
                        onClicked={() => player.next()}
                        visible={bind(player, "canGoNext")}>
                        <label label="󰒭" />
                    </button>
                </box>
                <box className="timer">
                    <label
                        className="position"
                        hexpand
                        halign={Gtk.Align.START}
                        visible={bind(player, "length").as(l => l > 0)}
                        label={bind(player, "position").as(lengthStr)}
                    />
                    <label
                        className="length"
                        hexpand
                        halign={Gtk.Align.END}
                        visible={bind(player, "length").as(l => l > 0)}
                        label={bind(player, "length").as(l => l > 0 ? lengthStr(l) : "0:00")}
                    />
                </box>
                <slider
                    visible={bind(player, "length").as(l => l > 0)}
                    onDragged={({ value }) => player.position = value * player.length}
                    value={position}
                />
            </box>
        </box>
    </Popover>

    return <eventbox onClick={() => visible1.set(true)} onHover={() => showSlider.set(true)} onHoverLost={() => showSlider.set(false)}>
        <box className="MediaPlayer" tooltipText={title_full}>
            <box className="cover-art" css={coverArt} />
            <box className="title">
                <label truncate hexpand halign={Gtk.Align.START} label={title_short} />
                <icon icon={playerIcon} />
            </box>
            <revealer
                setup={(self) => {
                    showSlider.subscribe((value) => {
                        self.revealChild = value;
                    })
                }}
                transitionType={Gtk.RevealerTransitionType.SLIDE_LEFT}>
                <box className="controller">
                    <button
                        onClicked={() => player.previous()}
                        visible={bind(player, "canGoPrevious")}>
                        <label label="󰒮" />
                    </button>
                    <button
                        onClicked={() => player.play_pause()}
                        visible={bind(player, "canControl")}>
                        <label label={playIcon} />
                    </button>
                    <button
                        onClicked={() => player.next()}
                        visible={bind(player, "canGoNext")}>
                        <label label="󰒭" />
                    </button>
                </box>
            </revealer>
        </box>
    </eventbox>
}

function playerSetup(player: Mpris.Player, showPlayer: Variable<Mpris.Player>, players: Array<Mpris.Player>) {
    bind(player, "available").subscribe((available) => {
        if (available === true) {
            showPlayer.set(player)
        } else {
            showPlayer.set(players.filter((val) => (val.get_bus_name() != player.get_bus_name())).at(0) ?? Mpris.Player.new("none"))
        }
    })
    bind(player, "playbackStatus").subscribe((status) => {
        if (status === Mpris.PlaybackStatus.PLAYING) {
            showPlayer.set(player)
        }
    })
}

export default function MprisPlayers() {
    const showPlayer = Variable(Mpris.Player.new("none"))

    const players = [
        Mpris.Player.new("spotify"),
        Mpris.Player.new("spotify_player"),
        Mpris.Player.new("io.bassi.Amberol"),
    ]

    for (const player of players) {
        if (player.available) {
            showPlayer.set(player);
            break;
        }
    }

    players.forEach(player => {
        playerSetup(player, showPlayer, players)
    });

    return <box>
        {bind(showPlayer).as(player => {
            if (player.available) {
                return <revealer setup={(self) => setTimeout(() => self.revealChild = true, 100)} transitionType={Gtk.RevealerTransitionType.CROSSFADE}>
                    <MediaPlayer player={player} />
                </revealer>
            } else {
                return <box />
            }
        })}
    </box>
}
