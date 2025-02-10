import { Gtk, Gdk, Astal } from "astal/gtk3"
import SysTray from "./SysTray"
import AudioSlider from "./AudioSlider"
import Workspaces from "./Workspaces"
import Time from "./Time"
import RAM from "./RAM"
import CPU from "./CPU"
import Home from "./Home"
import SwayNC from "./SwayNC"

const { Layer, WindowAnchor, Exclusivity } = Astal;

export default function Bar(monitor: Gdk.Monitor) {
    return <window className="Bar" namespace="ags" gdkmonitor={monitor} layer={Layer.BOTTOM} exclusivity={Exclusivity.EXCLUSIVE} anchor={WindowAnchor.TOP | WindowAnchor.LEFT | WindowAnchor.RIGHT}>
        <centerbox>
            <box halign={Gtk.Align.START}>
                <box>
                    <Home />
                    <Workspaces />
                </box>
            </box>
            <box>
                <box>
                </box>
            </box>
            <box halign={Gtk.Align.END} >
                <box>
                    <SysTray />
                    <AudioSlider />
                    <SwayNC />
                    <CPU />
                    <RAM />
                    <Time />
                </box>
            </box>
        </centerbox>
    </window>
}
