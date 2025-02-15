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

export default function MprisPlayers() {
    const mpris = Mpris.get_default()
    return <box>
        {bind(mpris, "players").as(arr => arr.filter(player => player.get_bus_name() == "org.mpris.MediaPlayer2.spotify" || player.get_bus_name() == "org.mpris.MediaPlayer2.spotify_player").map(player => (
            <MediaPlayer player={player} />
        )))}
    </box>
}
