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
                    id: managerButton
                    checked: true
                    text: "<font color='#D3C6AA'>Audio</font>"
                    onClicked: {
                        stack.currentIndex = 2;
                        outputButton.checked = false;
                        inputButton.checked = false;
                        managerButton.checked = true;
                    }
                    background: Rectangle {
                        implicitWidth: 70
                        implicitHeight: 30
                        color: managerButton.checked ? "#2E383C" : "#374145"
                        radius: 4
                    }
                }

                Button {
                    id: outputButton
                    text: "<font color='#D3C6AA'>Output</font>"
                    onClicked: {
                        stack.currentIndex = 0;
                        outputButton.checked = true;
                        inputButton.checked = false;
                        managerButton.checked = false;
                    }
                    background: Rectangle {
                        implicitWidth: 70
                        implicitHeight: 30
                        color: outputButton.checked ? "#2E383C" : "#374145"
                        radius: 4
                    }
                }

                Button {
                    id: inputButton
                    text: "<font color='#D3C6AA'>Input</font>"
                    onClicked: {
                        stack.currentIndex = 1;
                        outputButton.checked = false;
                        inputButton.checked = true;
                        managerButton.checked = false;
                    }
                    background: Rectangle {
                        implicitWidth: 70
                        implicitHeight: 30
                        color: inputButton.checked ? "#2E383C" : "#374145"
                        radius: 4
                    }
                }
            }

            StackLayout {
                id: stack
                Layout.alignment: Qt.AlignVCenter
                Layout.bottomMargin: 10
                currentIndex: 2

                ColumnLayout {
                    id: output
                    Layout.alignment: Qt.AlignVCenter
                    visible: false

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

                                color: "#D3C6AA"

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

                                color: "#D3C6AA"

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
                ColumnLayout {
                    id: manager
                    Layout.alignment: Qt.AlignVCenter
                    visible: false

                    Repeater {
                        model: Pipewire.nodes.values.filter(node => node.isStream == true).sort((a, b) => Utils.getAnyText(a).localeCompare(Utils.getAnyText(b)))
                        ColumnLayout {
                            id: rootC
                            required property PwNode modelData
                            RowLayout {
                                PwObjectTracker {
                                    objects: [rootC.modelData]
                                }

                                Layout.leftMargin: 15
                                Layout.rightMargin: 15

                                IconImage {
                                    id: volumeIconManager
                                    source: getIconVolumeOutput(rootC.modelData.audio)
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
                                    text: Utils.getAnyText(rootC.modelData)

                                    color: "#D3C6AA"

                                    MouseArea {
                                        acceptedButtons: Qt.LeftButton | Qt.RightButton
                                        implicitHeight: parent.height
                                        implicitWidth: parent.width

                                        onClicked: mouse => {
                                            if (mouse.button === Qt.LeftButton) {
                                                rootC.modelData.audio.muted = !rootC.modelData.audio.muted;
                                            } else if (mouse.button === Qt.RightButton) {
                                                rootC.modelData.audio.volume = 1;
                                                rootC.modelData.audio.muted = false;
                                            }
                                        }
                                    }
                                }
                            }
                            RowLayout {
                                Layout.leftMargin: 15
                                Layout.bottomMargin: 5
                                Layout.rightMargin: 15

                                Slider {
                                    id: slider
                                    from: 0.00
                                    to: 1.50

                                    stepSize: 0.01

                                    value: {
                                        rootC.modelData.audio.volume;
                                    }

                                    background: Rectangle {
                                        x: slider.leftPadding
                                        y: slider.topPadding + slider.availableHeight / 2 - height / 2
                                        implicitWidth: 200
                                        implicitHeight: 4
                                        width: slider.availableWidth
                                        height: implicitHeight
                                        radius: 2
                                        color: "#495156"

                                        Rectangle {
                                            width: slider.visualPosition * parent.width
                                            height: parent.height
                                            color: "#A7C080"
                                            radius: 2
                                        }
                                    }

                                    handle: Rectangle {
                                        x: slider.leftPadding + slider.visualPosition * (slider.availableWidth - width)
                                        y: slider.topPadding + slider.availableHeight / 2 - height / 2
                                        implicitWidth: 12
                                        implicitHeight: 12
                                        radius: implicitWidth / 2
                                        color: "#A7C080"
                                    }

                                    onMoved: {
                                        rootC.modelData.audio.volume = slider.value;
                                    }
                                }

                                Text {
                                    text: Math.round(rootC.modelData.audio.volume * 100) + "%"
                                    color: "#D3C6AA"
                                }
                            }
                        }
                    }
                }
            }
        }
        color: "#272E33"
        border.color: "#1E2326"
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
