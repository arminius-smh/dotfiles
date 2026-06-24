//@ pragma UseQApplication
import Quickshell
import "./modules/bar"
import QtQuick
import Quickshell.Io

Scope {
    id: root
    FileView {
        id: configFile
        path: Quickshell.env("HOME") + "/dotfiles/home-manager/programs/quickshell/config/config.json"
        blockLoading: true
        watchChanges: true
        onFileChanged: reload()
    }
    property var config: {
        return JSON.parse(configFile.text());
    }
    Bar {
        config: root.config
    }
}
