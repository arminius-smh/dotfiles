import QtQuick
import QtQuick.Layouts

import "../widgets"

RowLayout {
    id: row
    required property var toplevel
    required property var hostname

    anchors {
        left: parent.left
        leftMargin: 12
        verticalCenter: parent.verticalCenter
    }

    SysMenu {}

    HyprlandWorkspaces {
        screenName: row.toplevel.modelData.name
    }

    MprisPlayerLocal {
        show: row.hostname == "discovery"
    }
}
