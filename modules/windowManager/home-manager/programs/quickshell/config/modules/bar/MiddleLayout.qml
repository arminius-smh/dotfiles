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

    MprisPlayerLocal {
        show: row.hostname == "phoenix"
    }
}
