pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Layouts

import "../widgets"

RowLayout {
    id: row
    required property var toplevel
    required property var hostname
    required property var desktop

    anchors {
        left: parent.left
        leftMargin: 12
        verticalCenter: parent.verticalCenter
    }

    SysMenu {}

    Loader {
        active: row.desktop === "Hyprland"
        sourceComponent: HyprlandWorkspaces {
            screenName: row.toplevel.modelData.name
        }
    }

    Loader {
        active: row.desktop === "niri"
        sourceComponent: NiriWorkspaces {
            screenName: row.toplevel.modelData.name
        }
    }

    MprisPlayerLocal {
        show: row.hostname == "discovery"
    }
}
