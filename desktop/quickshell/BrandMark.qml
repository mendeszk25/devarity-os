// Official Devarity mark; screenshot QA v0.5.1.
// Absolute shell paths avoid dependence on QuickShell's working directory.
import QtQuick
import Quickshell

Item {
    id: mark
    property bool inverted: false

    Image {
        id: bitmap
        anchors.fill: parent
        source: "file://" + Quickshell.shellPath(
            mark.inverted
                ? "../../assets/branding/devarity-mark-dark.png"
                : "../../assets/branding/devarity-mark-light.png"
        )
        sourceSize: Qt.size(64, 64)
        fillMode: Image.PreserveAspectFit
        smooth: true
        cache: true
        asynchronous: false

        onStatusChanged: {
            if (status === Image.Error)
                console.warn("[DEVARITY][BRAND] Failed loading logo:", source)
        }
    }

    // Never reserve an empty rectangle when an image fails to load.
    Text {
        anchors.centerIn: parent
        visible: bitmap.status !== Image.Ready
        text: "D/"
        font.family: "monospace"
        font.bold: true
        font.pixelSize: Math.max(11, Math.min(18, mark.height * 0.55))
        color: mark.inverted ? "#090B0E" : "#E6E9E8"
    }
}
