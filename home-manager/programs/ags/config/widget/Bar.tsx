import { Gtk, Gdk, Astal } from "astal/gtk3"
import SysTray from "./SysTray"
import AudioSlider from "./AudioSlider"
import Workspaces from "./Workspaces"
import Time from "./Time"
import Status from "./Status"
import Home from "./Home"
import SwayNC from "./SwayNC"
import MprisPlayers from "./MprisPlayers"
import BluetoothStatus from "./BluetoothStatus"
import { exec } from "astal"

const { Layer, WindowAnchor, Exclusivity } = Astal;

function Separator(){
    return <label label="|" className="Separator" />
}

export default function Bar(monitor: Gdk.Monitor) {
    let hostname = exec(["bash", "-c", "hostname"])

    return <window className="Bar" namespace="ags" gdkmonitor={monitor} layer={Layer.BOTTOM} exclusivity={Exclusivity.EXCLUSIVE} anchor={WindowAnchor.TOP | WindowAnchor.LEFT | WindowAnchor.RIGHT}>
        <centerbox>
            <box halign={Gtk.Align.START}>
                <box>
                    <Home />
                    <Workspaces />
                    {hostname === "discovery" && <MprisPlayers />}
                </box>
            </box>
            <box>
                <box>
                    {hostname !== "discovery" && <MprisPlayers />}
                </box>
            </box>
            <box halign={Gtk.Align.END} >
                <box>
                    <SysTray />
                    <Separator />
                    <AudioSlider />
                    <BluetoothStatus />
                    <SwayNC />
                    <Status />
                    <Time />
                </box>
            </box>
        </centerbox>
    </window>
}
