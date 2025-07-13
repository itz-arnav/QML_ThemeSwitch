import QtQuick
import QtQuick.Controls
import ThemeToggle

ApplicationWindow {
    id: root
    width: 800; height: 600; visible: true
    title: "Theme switch"
    color: themeSwitch.checked ? "#333" : "#111"

    ThemeSwitch {
        id: themeSwitch
        anchors.centerIn: parent
    }
}
