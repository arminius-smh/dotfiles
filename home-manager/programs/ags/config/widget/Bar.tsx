import app from "ags/gtk4/app"
import { Astal, Gdk } from "ags/gtk4"
import { exec } from "ags/process"

import Home from "./Home"
import Workspaces from "./Workspaces"

import MprisPlayers from "./MprisPlayers"

import BluetoothStatus from "./BluetoothStatus"
import AudioSlider from "./AudioSlider"
import SwayNC from "./SwayNC"
import SysTray from "./SysTray"
import SysStatus from "./SysStatus"
import Time from "./Time"


function Separator() {
    return <label label="|" class="Separator" />
}

export default function Bar(gdkmonitor: Gdk.Monitor) {
    const { TOP, LEFT, RIGHT } = Astal.WindowAnchor

    let hostname = exec("hostname")

    return (
        <window
            layer={Astal.Layer.BOTTOM}
            visible
            name="bar"
            class="Bar"
            namespace="ags"
            gdkmonitor={gdkmonitor}
            exclusivity={Astal.Exclusivity.EXCLUSIVE}
            anchor={TOP | LEFT | RIGHT}
            application={app}
        >
            <centerbox cssName="centerbox">
                <box $type="start">
                    <Home />
                    <Workspaces />
                    {hostname === "discovery" && <MprisPlayers />}
                </box>
                <box $type="center">
                    {hostname !== "discovery" && <MprisPlayers />}
                </box>
                <box $type="end">
                    <SysTray />
                    <Separator />
                    <AudioSlider />
                    <BluetoothStatus />
                    <SwayNC />
                    <Separator />
                    <SysStatus />
                    <Separator />
                    <Time />
                </box>
            </centerbox>
        </window>
    )
}
