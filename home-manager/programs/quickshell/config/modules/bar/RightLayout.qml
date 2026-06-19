import QtQuick
import QtQuick.Layouts

import "../widgets"

RowLayout {
    id: row
    required property var hostname

    anchors {
        horizontalCenter: parent.horizontalCenter
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
