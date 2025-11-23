import Quickshell
import QtQuick
import QtQuick.Layouts

import "../widgets"

Scope {
    id: root

    Variants {
        model: Quickshell.screens

        PanelWindow {
            id: toplevel
            required property var modelData

            screen: modelData
            aboveWindows: false

            anchors {
                top: true
                left: true
                right: true
            }

            implicitHeight: 40

            color: "#1e1e2e"

            RowLayout {
                anchors {
                    left: parent.left
                    leftMargin: 12
                    verticalCenter: parent.verticalCenter
                }

                HyprlandWorkspaces {
                    screenName: toplevel.modelData.name
                }
            }

            RowLayout {
                anchors {
                    horizontalCenter: parent.horizontalCenter
                    verticalCenter: parent.verticalCenter
                }

                MprisPlayerLocal {}
            }

            RightLayout {}
        }
    }
}
