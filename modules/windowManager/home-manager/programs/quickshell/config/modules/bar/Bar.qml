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

            screen: modelData
            aboveWindows: false

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
            }

            MiddleLayout {
                hostname: toplevel.hostname
            }

            RightLayout {}

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
