// Devarity Shell 0.1: no login/autostart changes. Run with quickshell -p shell.qml.
// For first integration with Lilith hide its native bar using Super+B.
import QtQuick
import Quickshell

ShellRoot {
    id: shell

    property var menuScreen: null
    property bool menuVisible: false

    function toggleMenu(targetScreen) {
        if (menuVisible && menuScreen === targetScreen) {
            menuVisible = false
            menuScreen = null
        } else {
            menuScreen = targetScreen
            menuVisible = true
        }
    }

    function closeMenu() {
        menuVisible = false
        menuScreen = null
    }

    Variants {
        model: Quickshell.screens
        Topbar {
            onMenuRequested: shell.toggleMenu(modelData)
            menuOpen: shell.menuVisible && shell.menuScreen === modelData
        }
    }

    Variants {
        model: Quickshell.screens
        Dock {
            onMenuRequested: shell.toggleMenu(modelData)
        }
    }

    Variants {
        model: Quickshell.screens
        AppMenu {
            visible: shell.menuVisible && shell.menuScreen === modelData
            onCloseRequested: shell.closeMenu()
        }
    }
}
