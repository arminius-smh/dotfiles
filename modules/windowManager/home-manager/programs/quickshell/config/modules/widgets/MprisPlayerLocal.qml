import QtQuick
import QtQuick.Effects
import Quickshell.Services.Mpris
import Quickshell.Widgets
import QtQuick.Layouts

Repeater {
    id: root
    model: Mpris.players

    required property bool show

    RowLayout {
        id: mprisContainer
        required property MprisPlayer modelData
        visible: getSpotify(mprisContainer.modelData)

        function getSpotify(modelData) {
            if (!root.show) {
                return false;
            }
            if (modelData.dbusName.includes("org.mpris.MediaPlayer2.chromium")) {
                return true;
            } else if (modelData.dbusName == "org.mpris.MediaPlayer2.spotify") {
                return true;
            } else {
                return false;
            }
        }

        states: [
            State {
                name: "MprisPlayerHovered"
                when: hoverHandlerMpris.hovered
                PropertyChanges {
                    target: playerControls
                    opacity: 1
                }
            }
        ]
        transitions: [
            Transition {
                from: ""
                to: "MprisPlayerHovered"
                NumberAnimation {
                    properties: "opacity"
                    duration: 175
                    easing.type: Easing.InOutQuad
                }
            },
            Transition {
                from: "MprisPlayerHovered"
                to: ""
                NumberAnimation {
                    properties: "opacity"
                    duration: 175
                    easing.type: Easing.InOutQuad
                }
            }
        ]

        // TODO: only margin right needed
        HoverHandler {
            id: hoverHandlerMpris
            margin: playerControls.implicitWidth
        }
        // https://forum.qt.io/topic/145956/rounded-image-in-qt6/6
        Item {
            Layout.preferredWidth: songImage.implicitWidth
            Layout.preferredHeight: songImage.implicitHeight

            MouseArea {
                acceptedButtons: Qt.LeftButton
                implicitHeight: parent.height
                implicitWidth: parent.width

                onClicked: mprisContainer.modelData.togglePlaying()
            }

            IconImage {
                id: songImage
                source: mprisContainer.modelData.trackArtUrl
                implicitWidth: 30
                implicitHeight: 30
                visible: false
            }

            MultiEffect {
                source: songImage
                anchors.fill: songImage
                maskEnabled: true
                maskSource: songImageMask
                maskThresholdMin: 0.5
                maskSpreadAtMin: 1.0
            }

            Item {
                id: songImageMask
                width: songImage.width
                height: songImage.height
                layer.enabled: true
                visible: false
                Rectangle {
                    width: songImage.width
                    height: songImage.height
                    radius: width / 2
                    color: "black"
                }
            }
        }

        function songTitle(title) {
            if (title.length > 38) {
                title = title.substring(0, 35) + "...";
            }
            return title;
        }

        Text {
            color: "#cdd6f4"
            text: songTitle(mprisContainer.modelData.trackTitle)
            leftPadding: 5
            font.family: "Lexend"

            MouseArea {
                acceptedButtons: Qt.LeftButton
                implicitHeight: parent.height
                implicitWidth: parent.width

                onClicked: mprisContainer.modelData.togglePlaying()
            }
        }
        RowLayout {
            id: playerControls
            opacity: 0
            Layout.preferredWidth: 0

            Text {
                color: "#cdd6f4"
                font.pointSize: 14
                leftPadding: 3
                rightPadding: 5
                text: "󰒮"
                MouseArea {
                    acceptedButtons: Qt.LeftButton
                    implicitHeight: parent.height
                    implicitWidth: parent.width

                    onClicked: mprisContainer.modelData.previous()
                }
            }
            Text {
                color: "#cdd6f4"
                font.pointSize: 14
                rightPadding: 5
                text: playbackIcon(mprisContainer.modelData.playbackState)
                MouseArea {
                    acceptedButtons: Qt.LeftButton
                    implicitHeight: parent.height
                    implicitWidth: parent.width

                    onClicked: mprisContainer.modelData.togglePlaying()
                }
            }
            Text {
                color: "#cdd6f4"
                font.pointSize: 14
                text: "󰒭"
                MouseArea {
                    acceptedButtons: Qt.LeftButton
                    implicitHeight: parent.height
                    implicitWidth: parent.width

                    onClicked: mprisContainer.modelData.next()
                }
            }
        }

        function playbackIcon(playback) {
            if (playback == MprisPlaybackState.Playing) {
                return "󰏤";
            } else {
                return "󰐊";
            }
        }
    }
}
