import QtQuick
import QtQuick.Layouts
import Niri 0.1

Rectangle {
    id: root
    implicitWidth: rowLayout.implicitWidth + 20
    implicitHeight: 25
    Layout.rightMargin: 5
    color: "#313244"
    radius: height / 2

    property var screenName

    Niri {
        id: niri
        Component.onCompleted: connect()
    }

    RowLayout {
        id: rowLayout
        anchors.centerIn: parent

        Repeater {
            model: niri.workspaces

            Text {
                id: workspaceText
                visible: model.output == root.screenName && (model.activeWindowId != 0 || model.isActive)
                Layout.minimumWidth: 15

                text: workspaceTextFunc(model)
                color: workspaceColorFunc(model)

                property var workspaceId: model.id

                function workspaceColorFunc(mod) {
                    let color = "";
                    if (mod.isFocused) {
                        color = "#74c7ec";
                    } else if (workspaceMouse.containsMouse) {
                        color = "#eba0ac";
                    } else {
                        color = "#74c7ec";
                    }
                    return color;
                }

                function workspaceTextFunc(mod) {
                    let icon = "";
                    if (mod.isFocused) {
                        icon = "";
                    } else if (mod.index == 9) {
                        icon = "";
                    } else {
                        icon = "";
                    }
                    return icon;
                }
                MouseArea {
                    id: workspaceMouse
                    hoverEnabled: true
                    acceptedButtons: Qt.LeftButton
                    anchors.fill: parent

                    onClicked: niri.focusWorkspaceById(workspaceText.workspaceId)
                }
            }
        }
    }
}
