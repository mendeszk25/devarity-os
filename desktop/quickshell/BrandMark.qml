// The mark was supplied by the Devarity OS project owner.
// Transparency and aspect ratio are preserved; no CPU animation.
import QtQuick

Image {
    id: mark
    property bool inverted: false
    source: inverted
        ? Qt.resolvedUrl("../../assets/branding/devarity-mark-dark.png")
        : Qt.resolvedUrl("../../assets/branding/devarity-mark-light.png")
    sourceSize: Qt.size(64, 64)
    fillMode: Image.PreserveAspectFit
    smooth: true
    cache: true
    asynchronous: true
}
