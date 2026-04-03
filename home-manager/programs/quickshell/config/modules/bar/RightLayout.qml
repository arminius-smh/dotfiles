import QtQuick
import QtQuick.Layouts

import "../widgets"

RowLayout {
    id: row
    required property var hostname

    anchors {
        right: parent.right
        rightMargin: 12
        verticalCenter: parent.verticalCenter
    }
    SysTrayLocal {}

    Loader {
        active: row.hostname === "discovery"
        sourceComponent: BatteryLocal {}
    }

    NotificationLocal {}

    AudioLocal {}

    ClockLocal {}
}
