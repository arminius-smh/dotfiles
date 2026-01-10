import QtQuick
import Quickshell.Services.Pipewire
import Quickshell
import QtQuick.Layouts
import QtQuick.Controls
import Quickshell.Widgets
import "utils.js" as Utils

PopupWindow {
    id: audioPopup
    required property var audioIconRoot
    anchor.item: audioIconRoot
    anchor.rect.y: audioIconRoot.implicitHeight + 34
    anchor.rect.x: audioIconRoot.x + audioIconRoot.width / 2 - implicitWidth / 2
    implicitWidth: rec.implicitWidth
    implicitHeight: rec.implicitHeight

    HoverHandler {
        id: audioHover
        onHoveredChanged: timer.running = true
    }
    Rectangle {
        id: rec
        implicitWidth: colLayout.implicitWidth
        implicitHeight: colLayout.implicitHeight
        anchors.fill: parent
        radius: 6

        ColumnLayout {
            id: colLayout
            RowLayout {
                id: tabs
                Layout.alignment: Qt.AlignHCenter
                Layout.topMargin: 5

                Button {
                    id: outputButton
                    text: "Output"
                    checked: true
                    onClicked: {
                        stack.currentIndex = 0;
                        outputButton.checked = true;
                        inputButton.checked = false;
                    }
                    background: Rectangle {
                        implicitWidth: 70
                        implicitHeight: 30
                        color: "#45475a"
                        border.color: outputButton.checked ? "#b4befe" : "#313244"
                        border.width: 1
                        radius: 4
                    }
                }

                Button {
                    id: inputButton
                    text: "Input"
                    onClicked: {
                        stack.currentIndex = 1;
                        outputButton.checked = false;
                        inputButton.checked = true;
                    }
                    background: Rectangle {
                        implicitWidth: 70
                        implicitHeight: 30
                        color: "#45475a"
                        border.color: inputButton.checked ? "#b4befe" : "#313244"
                        border.width: 1
                        radius: 4
                    }
                }
            }

            StackLayout {
                id: stack
                Layout.alignment: Qt.AlignVCenter
                currentIndex: 0

                ColumnLayout {
                    id: output
                    Layout.alignment: Qt.AlignVCenter
                    visible: true

                    Repeater {
                        model: Pipewire.nodes.values.filter(node => node.isStream == false && node.type == 17).sort((a, b) => a.id - b.id)

                        RowLayout {
                            id: rootA
                            required property PwNode modelData

                            PwObjectTracker {
                                objects: [rootA.modelData]
                            }

                            Layout.leftMargin: 15
                            Layout.bottomMargin: 5
                            Layout.rightMargin: 15

                            IconImage {
                                id: defaultIconOutput
                                source: getIconDefaultOutput(rootA.modelData)
                                implicitSize: 20

                                function getIconDefaultOutput(node) {
                                    let icon = "";

                                    if (Pipewire.preferredDefaultAudioSink == node) {
                                        icon = "checkmark";
                                    } else {
                                        icon = "checkbox-symbolic";
                                    }

                                    return "image://icon/" + icon;
                                }
                            }

                            IconImage {
                                id: volumeIconOutput
                                source: getIconVolumeOutput(rootA.modelData.audio)
                                implicitSize: 20

                                function getIconVolumeOutput(audio) {
                                    let icon = "";
                                    if (audio.muted) {
                                        icon = "audio-volume-muted";
                                    } else {
                                        icon = "audio-volume-high";
                                    }
                                    return "image://icon/" + icon;
                                }
                            }

                            Text {
                                text: Utils.getAnyText(rootA.modelData)

                                color: "#cdd6f4"

                                MouseArea {
                                    acceptedButtons: Qt.LeftButton | Qt.RightButton
                                    implicitHeight: parent.height
                                    implicitWidth: parent.width

                                    onClicked: {
                                        Pipewire.preferredDefaultAudioSink = rootA.modelData;
                                    }

                                    onDoubleClicked: {
                                        rootA.modelData.audio.muted = !rootA.modelData.audio.muted;
                                    }
                                }
                            }
                        }
                    }
                }
                ColumnLayout {
                    id: input
                    Layout.alignment: Qt.AlignVCenter
                    visible: false

                    Repeater {
                        model: Pipewire.nodes.values.filter(node => node.isStream == false && node.type == 9).sort((a, b) => Utils.getAnyText(a).localeCompare(Utils.getAnyText(b)))
                        RowLayout {
                            id: rootB
                            required property PwNode modelData

                            PwObjectTracker {
                                objects: [rootB.modelData]
                            }

                            Layout.leftMargin: 15
                            Layout.bottomMargin: 5
                            Layout.rightMargin: 15

                            IconImage {
                                id: defaultIconInput
                                source: getIconDefaultOutput(rootB.modelData)
                                implicitSize: 20

                                function getIconDefaultOutput(node) {
                                    let icon = "";

                                    if (Pipewire.preferredDefaultAudioSource == node) {
                                        icon = "checkmark";
                                    } else {
                                        icon = "checkbox-symbolic";
                                    }

                                    return "image://icon/" + icon;
                                }
                            }

                            IconImage {
                                id: volumeIconInput
                                source: getIconVolumeOutput(rootB.modelData.audio)
                                implicitSize: 20

                                function getIconVolumeOutput(audio) {
                                    let icon = "";
                                    if (audio.muted) {
                                        icon = "audio-volume-muted";
                                    } else {
                                        icon = "audio-volume-high";
                                    }
                                    return "image://icon/" + icon;
                                }
                            }

                            Text {
                                text: Utils.getAnyText(rootB.modelData)

                                color: "#cdd6f4"

                                MouseArea {
                                    acceptedButtons: Qt.LeftButton | Qt.RightButton
                                    implicitHeight: parent.height
                                    implicitWidth: parent.width

                                    onClicked: mouse => {
                                        Pipewire.preferredDefaultAudioSource = rootB.modelData;
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
        color: "#313244"
        border.color: "#b4befe"
    }

    Timer {
        id: timer
        interval: 1500
        repeat: false
        onTriggered: {
            if (!audioHover.hovered) {
                audioPopup.visible = false;
            }
        }
    }
    onVisibleChanged: timer.running = true
    color: "transparent"
    visible: false
}
