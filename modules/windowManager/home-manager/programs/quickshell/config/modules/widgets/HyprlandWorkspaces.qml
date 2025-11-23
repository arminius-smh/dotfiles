import QtQuick
import QtQuick.Layouts
import Quickshell.Hyprland

Rectangle {
    width: rowLayout.implicitWidth + 20
    height: 25
    color: "#313244"
    radius: height / 2

    property var screenName

    RowLayout {
        id: rowLayout
        anchors.centerIn: parent

        Repeater {
            model: Hyprland.workspaces.values.filter(item => item.id > 0).filter(item => screenName === item.monitor?.name)

            Text {
                id: workspaceText
                required property HyprlandWorkspace modelData
                Layout.minimumWidth: 15

                text: workspaceTextFunc()
                color: workspaceColorFunc()

                function workspaceColorFunc() {
                    let color = "";
                    if (modelData.focused) {
                        color = "#74c7ec";
                    } else if (workspaceMouse.containsMouse) {
                        color = "#eba0ac";
                    } else {
                        color = "#74c7ec";
                    }
                    return color;
                }

                function workspaceTextFunc() {
                    let icon = "";
                    if (modelData.focused) {
                        icon = "";
                    // } else if (modelData.name == "mail") {
                    //     icon = "";
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

                    onClicked: Hyprland.dispatch("workspace " + workspaceText.modelData.id)
                }
            }
        }
    }
}
