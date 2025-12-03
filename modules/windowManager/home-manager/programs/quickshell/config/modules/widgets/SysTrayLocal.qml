import Quickshell
import QtQuick
import Quickshell.Services.SystemTray
import Quickshell.Widgets
import QtQuick.Controls
import QtQuick.Layouts

RowLayout {
    Repeater {
        model: SystemTray.items.values.filter(item => item.status != Status.Passive)

        Item {
            id: itemSysTrayContainer
            required property SystemTrayItem modelData

            visible: modelData.status != Status.Passive
            implicitHeight: trayIcon.implicitHeight
            implicitWidth: trayIcon.implicitWidth
            IconImage {
                id: trayIcon
                visible: itemSysTrayContainer.modelData.icon !== null
                source: itemSysTrayContainer.modelData.icon
                implicitSize: 20
                anchors.fill: parent
            }

            PopupWindow {
                id: tooltipPopup
                anchor.item: trayIcon
                anchor.rect.y: trayIcon.implicitHeight + 12
                anchor.rect.x: trayIcon.x + trayIcon.width / 2 - implicitWidth / 2
                implicitWidth: percentageText.width + 16
                implicitHeight: percentageText.height + 4
                Rectangle {
                    anchors.fill: parent
                    radius: 6
                    Text {
                        id: percentageText
                        anchors.centerIn: parent
                        text: toolTipText(itemSysTrayContainer.modelData)
                        color: "#cdd6f4"

                        function toolTipText(tooltipData) {
                            if (tooltipData.tooltipTitle != 0) {
                                return tooltipData.tooltipTitle;
                            } else if (tooltipData.tooltipDescription != 0) {
                                return tooltipData.tooltipDescription;
                            } else {
                                return tooltipData.title;
                            }
                        }
                    }
                    color: "#313244"
                    border.color: "#b4befe"
                }
                color: "transparent"
                visible: false
            }

            MouseArea {
                id: tooltipMouse
                acceptedButtons: Qt.LeftButton | Qt.RightButton | Qt.MiddleButton
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
                    onTriggered: if (tooltipMouse.containsMouse)
                        tooltipPopup.visible = true
                }

                onClicked: mouse => {
                    if (itemSysTrayContainer.modelData.onlyMenu) {
                        sysTrayMenu.open();
                    } else {
                        if (mouse.button == Qt.LeftButton) {
                            itemSysTrayContainer.modelData.activate();
                        } else if (mouse.button == Qt.MiddleButton) {
                            itemSysTrayContainer.modelData.secondaryActivate();
                        } else {
                            if (itemSysTrayContainer.modelData.hasMenu) {
                                sysTrayMenu.open();
                            } else {
                                itemSysTrayContainer.modelData.activate();
                            }
                        }
                    }
                }
            }
            QsMenuAnchor {
                id: sysTrayMenu
                menu: itemSysTrayContainer.modelData.menu
                anchor {
                    item: trayIcon
                    edges: Edges.Bottom
                    gravity: Edges.Bottom

                    margins.top: 28
                }
            }
        }
    }
}
