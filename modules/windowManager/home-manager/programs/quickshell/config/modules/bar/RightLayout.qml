import QtQuick
import QtQuick.Layouts

import "../widgets"
RowLayout {
    anchors {
        right: parent.right
        rightMargin: 12
        verticalCenter: parent.verticalCenter
    }
    SysTrayLocal {}

    AudioLocal {}

    ClockLocal {}
}
