import QtQuick
import Quickshell.Services.UPower
import Quickshell.Widgets
import QtQuick.Layouts
import Quickshell

RowLayout {
    id: root
    property UPowerDevice defaultPower: UPower.displayDevice
    visible: defaultPower.isPresent

    IconImage {
        id: batteryIcon
        source: "image://icon/" + root.defaultPower.iconName
        implicitSize: 20

        PopupWindow {
            id: tooltipPopup
            anchor.item: batteryIcon
            anchor.rect.y: batteryIcon.implicitHeight + 12
            anchor.rect.x: batteryIcon.x + batteryIcon.width / 2 - implicitWidth / 2
            implicitWidth: percentageText.width + 16
            implicitHeight: percentageText.height + 4
            Rectangle {
                anchors.fill: parent
                radius: 6
                Text {
                    id: percentageText
                    anchors.centerIn: parent
                    text: root.defaultPower.percentage * 100 + "%"
                    color: "#cdd6f4"
                }
                color: "#313244"
                border.color: "#b4befe"
            }
            color: "transparent"
            visible: false
        }

        MouseArea {
            id: tooltipBattery
            implicitHeight: parent.height
            implicitWidth: parent.width
            hoverEnabled: true
            onEntered: timer.running = true
            onExited: {
                timer.running = false;
                tooltipPopup.visible = false;
            }

            Timer {
                id: timer
                interval: 400
                repeat: false
                onTriggered: if (tooltipBattery.containsMouse)
                    tooltipPopup.visible = true
            }
        }
    }
}
