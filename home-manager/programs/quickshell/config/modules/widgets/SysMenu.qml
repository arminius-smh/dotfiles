import QtQuick
import Quickshell
import QtQuick.Layouts
import Quickshell.Widgets

Rectangle {
    id: root

    // potential border around icon
    implicitWidth: icon.implicitWidth
    implicitHeight: icon.implicitHeight
    color: "transparent"
    radius: height / 2
    IconImage {
        id: icon
        source: "file:///home/armin/dotfiles/assets/pics/NixOS-blue.svg"
        implicitSize: 25
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter

        MouseArea {
            acceptedButtons: Qt.LeftButton | Qt.RightButton
            implicitHeight: parent.height
            implicitWidth: parent.width

            onClicked: mouse => {
                if (mouse.button == Qt.LeftButton) {
                    sysPopup.visible = true;
                }
            }
        }

        PopupWindow {
            id: sysPopup
            anchor.item: root
            anchor.rect.x: root.width / 2 - width / 2
            anchor.rect.y: root.height
            implicitWidth: rec.implicitWidth
            implicitHeight: rec.implicitHeight

            HoverHandler {
                id: sysHover
                onHoveredChanged: timer.running = true
            }

            Rectangle {
                id: rec
                implicitWidth: functions.implicitWidth
                implicitHeight: functions.implicitHeight
                anchors.fill: parent
                radius: 12
                color: "#313244"
                border.color: "#b4befe"

                ColumnLayout {
                    id: functions

                    RowLayout {
                        Layout.alignment: Qt.AlignHCenter

                        Text {
                            text: "󰐥"
                            font.pointSize: 22
                            leftPadding: 10
                            color: "#89b4fa"

                            MouseArea {
                                acceptedButtons: Qt.LeftButton
                                implicitHeight: parent.height
                                implicitWidth: parent.width
                                hoverEnabled: true
                                onEntered: parent.color = "#b4befe"
                                onExited: parent.color = "#89b4fa"

                                onClicked: {
                                    Quickshell.execDetached(["shutdown", "--no-wall", "now"]);
                                }
                            }
                        }
                        Text {
                            text: ""
                            font.pointSize: 22
                            leftPadding: 10
                            color: "#89b4fa"

                            MouseArea {
                                acceptedButtons: Qt.LeftButton
                                implicitHeight: parent.height
                                implicitWidth: parent.width
                                hoverEnabled: true
                                onEntered: parent.color = "#b4befe"
                                onExited: parent.color = "#89b4fa"

                                onClicked: {
                                    Quickshell.execDetached(["loginctl", "lock-session"]);
                                }
                            }
                        }
                        Text {
                            text: "󰜉"
                            font.pointSize: 22
                            leftPadding: 10
                            rightPadding: 10
                            color: "#89b4fa"
                            MouseArea {
                                acceptedButtons: Qt.LeftButton
                                implicitHeight: parent.height
                                implicitWidth: parent.width
                                hoverEnabled: true
                                onEntered: parent.color = "#b4befe"
                                onExited: parent.color = "#89b4fa"

                                onClicked: {
                                    Quickshell.execDetached(["reboot", "--no-wall"]);
                                }
                            }
                        }
                    }

                    RowLayout {
                        Layout.alignment: Qt.AlignHCenter

                        Text {
                            text: ""
                            font.pointSize: 22
                            leftPadding: 10
                            color: "#89b4fa"
                            MouseArea {
                                acceptedButtons: Qt.LeftButton
                                implicitHeight: parent.height
                                implicitWidth: parent.width
                                hoverEnabled: true
                                onEntered: parent.color = "#b4befe"
                                onExited: parent.color = "#89b4fa"

                                onClicked: {
                                    Quickshell.execDetached(["systemctl", "hibernate"]);
                                }
                            }
                        }
                        Text {
                            text: "󰗽"
                            font.pointSize: 22
                            leftPadding: 10
                            color: "#89b4fa"

                            MouseArea {
                                acceptedButtons: Qt.LeftButton
                                implicitHeight: parent.height
                                implicitWidth: parent.width
                                hoverEnabled: true
                                onEntered: parent.color = "#b4befe"
                                onExited: parent.color = "#89b4fa"

                                onClicked: {
                                    Quickshell.execDetached(["uwsm", "stop"]);
                                }
                            }
                        }
                        Text {
                            text: "󰤄"
                            font.pointSize: 22
                            leftPadding: 10
                            rightPadding: 10
                            color: "#89b4fa"

                            MouseArea {
                                acceptedButtons: Qt.LeftButton
                                implicitHeight: parent.height
                                implicitWidth: parent.width
                                hoverEnabled: true
                                onEntered: parent.color = "#b4befe"
                                onExited: parent.color = "#89b4fa"

                                onClicked: {
                                    Quickshell.execDetached(["systemctl", "suspend"]);
                                }
                            }
                        }
                    }
                }
            }

            Timer {
                id: timer
                interval: 1500
                repeat: false
                onTriggered: {
                    if (!sysHover.hovered) {
                        sysPopup.visible = false;
                    }
                }
            }
            onVisibleChanged: timer.running = true

            color: "transparent"
            visible: false
        }
    }
}
