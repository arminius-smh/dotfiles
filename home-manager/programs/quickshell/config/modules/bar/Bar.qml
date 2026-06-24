pragma ComponentBehavior: Bound
import Quickshell
import QtQuick
import QtQuick.Layouts
import Quickshell.Io

import "../widgets"

Scope {
    id: root
    required property var config


    Variants {
        model: Quickshell.screens

        PanelWindow {
            id: toplevel
            required property var modelData
            property var hostname
            property string desktop: Quickshell.env("XDG_CURRENT_DESKTOP")

            screen: modelData
            aboveWindows: true

            anchors {
                top: true
                left: true
                right: true
            }

            implicitHeight: 40

            color: "#00000000"

            Rectangle {
                id: borderleft
                width: left.width + 20
                height: 35

                color: Qt.alpha(root.config.colors.bg, 0.8)
                radius: border.height / 2

                anchors {
                    left: parent.left
                    leftMargin: 12
                    verticalCenter: parent.verticalCenter
                }

                LeftLayout {
                    id: left
                    toplevel: toplevel
                    hostname: toplevel.hostname
                    desktop: toplevel.desktop
                }
            }

            MiddleLayout {
                hostname: toplevel.hostname
            }

            Rectangle {
                id: border
                width: right.width + 20
                height: 35

                color: Qt.alpha(root.config.colors.bg, 0.8)
                radius: border.height / 2

                anchors {
                    right: parent.right
                    rightMargin: 5
                    verticalCenter: parent.verticalCenter
                }

                RightLayout {
                    id: right
                    hostname: toplevel.hostname
                }
            }

            Process {
                running: true
                command: ["hostname"]
                stdout: StdioCollector {
                    id: hostnameCollector
                    onStreamFinished: toplevel.hostname = this.text.trim()
                }
            }
        }
    }
}
