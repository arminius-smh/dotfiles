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
                implicitWidth: 20
                implicitHeight: 20
                anchors.fill: parent
            }

            ToolTip {
                // TODO: open Tooltip under Icon
                text: toolTipText(itemSysTrayContainer.modelData)
                visible: tooltipMouse.containsMouse
                delay: 800
                topMargin: 15

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
            MouseArea {
                id: tooltipMouse
                acceptedButtons: Qt.LeftButton | Qt.RightButton | Qt.MiddleButton
                implicitHeight: parent.height
                implicitWidth: parent.width
                hoverEnabled: true

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
