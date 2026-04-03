import Quickshell
import QtQuick
import QtQuick.Layouts
import Quickshell.Io

import "../widgets"

Scope {
    id: root

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

            color: "#1e1e2e"

            LeftLayout {
                toplevel: toplevel
                hostname: toplevel.hostname
                desktop: toplevel.desktop
            }

            MiddleLayout {
                hostname: toplevel.hostname
            }

            RightLayout {
                hostname: toplevel.hostname
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
