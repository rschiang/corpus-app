import QtQuick 2.0
import QtGraphicalEffects 1.0

Item {
    id: root
    state: mouseArea.pressed ? "z-2" : "z-1"

    Rectangle {
        id: background
        anchors.fill: parent
        color: "white"
        radius: 2
        visible: false
    }

    DropShadow {
        id: topShadow
        anchors.fill: parent
        source: background
        spread: 0.0
        samples: 32
        transparentBorder: true
    }

    DropShadow {
        id: bottomShadow
        anchors.fill: parent
        source: background
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
            PropertyChanges { target: topShadow; verticalOffset: 2; radius: 10; color: "#28000000" }
            PropertyChanges { target: bottomShadow; verticalOffset: 2; radius: 5; color: "#42000000" }
        },
        State {
            name: "z-2"
            PropertyChanges { target: topShadow; verticalOffset: 6; radius: 20; color: "#30000000" }
            PropertyChanges { target: bottomShadow; verticalOffset: 8; radius: 17; color: "#33000000" }
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

    MouseArea {
        id: mouseArea
        anchors.fill: parent
    }
}
