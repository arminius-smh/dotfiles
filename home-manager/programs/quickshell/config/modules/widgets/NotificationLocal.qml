import QtQuick
import Quickshell
import QtQuick.Layouts
import Quickshell.Io

Item {
    id: root
    Layout.preferredWidth: 24
    Layout.preferredHeight: swayNCIcon.implicitHeight

    Text {
        id: swayNCIcon
        text: processSwayNC()
        textFormat: Text.RichText
        font.pointSize: 16
        leftPadding: 6
        color: swayNCIcon.text == "󰂛 " ? "#7f849c" :  "#89b4fa" 

        MouseArea {
            acceptedButtons: Qt.LeftButton | Qt.RightButton
            implicitHeight: parent.height
            implicitWidth: parent.width

            onClicked: mouse => {
                if (mouse.button == Qt.LeftButton) {
                    Quickshell.execDetached(["swaync-client", "-t", "-sw"]);
                } else {
                    Quickshell.execDetached(["swaync-client", "-d", "-sw"]);
                }
            }
        }

        function processSwayNC() {
            const raw = swayncstdio.text;
            const lines = raw.trim().split("\n");
            let last = {};
            if (lines.length > 0) {
                try {
                    last = JSON.parse(lines[lines.length - 1]);
                } catch (e) {
                    last = {}; // fallback if parsing fails
                }
            }
            let icon = "";
            if (last.alt == "none") {
                icon = "󰂚 ";
            } else if (last.alt == "notification") {
                icon = "󰂚<span style='color:#d20f39; font-size:14px;'><sup></sup></span>";
            } else if (last.alt == "dnd-notification" || last.alt == "dnd-none") {
                icon = "󰂛 ";
            } else {
                icon = "";
            }

            return icon;
        }
        Process {
            id: swaync
            command: ["swaync-client", "-swb"]

            running: true

            stdout: StdioCollector {
                id: swayncstdio
                waitForEnd: false
            }
        }
    }
}
