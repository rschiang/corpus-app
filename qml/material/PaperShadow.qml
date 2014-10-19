import QtQuick 2.0
import QtGraphicalEffects 1.0

Item {
    id: root
    anchors.fill: parent
    state: "z-" + Math.max(0, Math.min(5, depth))

    property variant source
    property int depth: 0

    DropShadow {
        id: topShadow
        anchors.fill: parent
        source: root.source
        spread: 0.0
        samples: 32
        transparentBorder: true
    }

    DropShadow {
        id: bottomShadow
        anchors.fill: parent
        source: root.source
        spread: 0.0
        samples: 32
        transparentBorder: true
    }

    states: [
        State {
            name: "z-0"
            PropertyChanges { target: topShadow; verticalOffset: 0; radius: 0; color: "#00000000" }
            PropertyChanges { target: bottomShadow; verticalOffset: 0; radius: 0; color: "#00000000" }
        },
        State {
            name: "z-1"
            PropertyChanges { target: topShadow; verticalOffset: 1 * dp; radius: 1.5 * dp; color: "#28000000" }
            PropertyChanges { target: bottomShadow; verticalOffset: 1 * dp; radius: 1 * dp; color: "#42000000" }
        },
        State {
            name: "z-2"
            PropertyChanges { target: topShadow; verticalOffset: 3 * dp; radius: 3 * dp; color: "#30000000" }
            PropertyChanges { target: bottomShadow; verticalOffset: 3 * dp; radius: 3 * dp; color: "#33000000" }
        }
    ]

    transitions: [
        Transition {
            NumberAnimation {
                targets: [topShadow, bottomShadow]
                properties: "verticalOffset,radius"
                duration: 280
                easing.type: Easing.Bezier; easing.bezierCurve: [0.4, 0, 0.2, 1, 1, 1]
            }
            ColorAnimation {
                targets: [topShadow, bottomShadow]
                duration: 280
            }
        }

    ]
}
