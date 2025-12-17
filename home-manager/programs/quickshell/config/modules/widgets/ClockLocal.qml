import Quickshell.Io
import QtQuick

Item {
    implicitWidth: 40

    Text {
        id: time
        color: "#cdd6f4"
        anchors.verticalCenter: parent.verticalCenter
        anchors.right: parent.right
    }

    Process {
        id: dateProc

        command: ["date", "+%H:%M"]
        running: true

        stdout: StdioCollector {
            onStreamFinished: time.text = this.text
        }
    }

    Timer {
        interval: 1000
        running: true
        repeat: true
        onTriggered: dateProc.running = true
    }
}
