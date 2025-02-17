import { Astal, Gtk } from "astal/gtk3"
import Mpris from "gi://AstalMpris"
import { Variable, bind } from "astal"

function MediaPlayer({ player }: { player: Mpris.Player }) {
    const { START } = Gtk.Align

    const title_short = bind(player, "title").as(t => {
        if (t.length > 38) {
            t = t.substring(0, 35) + "...";
        }
        return t || "Unknown Track"
    })

    const title_full = bind(player, "title").as(t => {
        return t || "Unknown Track"
    })

    const coverArt = bind(player, "coverArt").as(c =>
        `background-image: url('${c}')`)

    const playerIcon = bind(player, "entry").as(e =>
        e != null && Astal.Icon.lookup_icon(e) ? e : "audio-x-generic-symbolic")

    const playIcon = bind(player, "playbackStatus").as(s =>
        s === Mpris.PlaybackStatus.PLAYING
            ? "󰏤"
            : "󰐊"
    )

    let showSlider = Variable(false)

    return <eventbox onHover={() => showSlider.set(true)} onHoverLost={() => showSlider.set(false)}>
        <box className="MediaPlayer" tooltipText={title_full}>
            <box className="cover-art" css={coverArt} />
            <box className="title">
                <label truncate hexpand halign={START} label={title_short} />
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
    const mpris = Mpris.get_default()

    const showPlayer = Variable(Mpris.Player.new(mpris.get_players().at(0)?.get_bus_name() ?? "none"))

    const players = [
        Mpris.Player.new("spotify"),
        Mpris.Player.new("spotify_player"),
        Mpris.Player.new("io.bassi.Amberol"),
    ]

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
