// The underground system frame: intentionally static and lightweight.
// Pure ornament. No synthetic system telemetry, shaders, loops, or timers.
import QtQuick

Item {
    id: frame
    property bool compact: false
    property color accent: "#8BC9EA"
    property color hairline: "#32414D"
    enabled: false
    clip: true

    // Upper-left technical bracket.
    Rectangle {
        x: 1; y: 1
        width: Math.min(52, Math.max(0, frame.width * 0.18))
        height: 2
        color: frame.accent
        opacity: .85
    }
    Rectangle {
        x: 1; y: 1
        width: 2; height: frame.compact ? 8 : 18
        color: frame.accent
        opacity: .85
    }

    // Lower-right split motif, derived from the central blade of the mark.
    Rectangle {
        x: Math.max(0, frame.width - 48); y: Math.max(0, frame.height - 2)
        width: 47; height: 2
        color: frame.accent
        opacity: .72
    }
    Rectangle {
        x: Math.max(0, frame.width - 2)
        y: Math.max(0, frame.height - (frame.compact ? 10 : 20))
        width: 2; height: frame.compact ? 10 : 20
        color: frame.accent
        opacity: .7
    }
    Rectangle {
        x: Math.max(0, frame.width - 66)
        y: 2
        width: 3; height: frame.compact ? 6 : 10
        rotation: -25
        color: frame.accent
        opacity: .5
    }

    // Small barcode-like stripes, never animated.
    Repeater {
        model: frame.compact ? 3 : 7
        Rectangle {
            required property int index
            x: Math.max(3, frame.width - 24 - index * 11)
            y: Math.max(0, frame.height - 6)
            width: index % 3 === 0 ? 6 : 3
            height: 2
            color: frame.accent
            opacity: index % 2 === 0 ? .6 : .25
        }
    }
}
