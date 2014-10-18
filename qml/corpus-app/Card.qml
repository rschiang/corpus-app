import QtQuick 2.0
import QtGraphicalEffects 1.0

Item {
    id: root
    state: mouseArea.pressed ? "pressed" : "normal"

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
        cached: true

        color: "#1e000000"
        horizontalOffset: 0
        verticalOffset: 1
        radius: 1.5
        spread: 0.0
        samples: 32
        transparentBorder: true
    }

    DropShadow {
        id: bottomShadow
        anchors.fill: parent
        source: background
        cached: true

        color: "#3d000000"
        horizontalOffset: 0
        verticalOffset: 1
        radius: 1.0
        spread: 0.0
        samples: 32
        transparentBorder: true
    }

    states: [
        State {
            name: "normal"
            PropertyChanges { target: topShadow; color: "#1e000000"; verticalOffset: 1; radius: 1.5; }
            PropertyChanges { target: bottomShadow; color: "#3d000000"; verticalOffset: 1; radius: 1; }
        },
        State {
            name: "pressed"
            PropertyChanges { target: topShadow; color: "#30000000"; verticalOffset: 10; radius: 10; }
            PropertyChanges { target: bottomShadow; color: "#3a000000"; verticalOffset: 6; radius: 3; }
        }
    ]

    transitions: [
        Transition {
            from: "normal"
            to: "pressed"
            ColorAnimation { target: topShadow; duration: 100 }
            ColorAnimation { target: bottomShadow; duration: 100 }
            NumberAnimation { target: topShadow; properties: "radius,verticalOffset"; duration: 100 }
            NumberAnimation { target: bottomShadow; properties: "radius,verticalOffset"; duration: 100 }
        },
        Transition {
            from: "pressed"
            to: "normal"
            ColorAnimation { target: topShadow; duration: 300 }
            ColorAnimation { target: bottomShadow; duration: 300 }
            NumberAnimation { target: topShadow; properties: "radius,verticalOffset"; duration: 300 }
            NumberAnimation { target: bottomShadow; properties: "radius,verticalOffset"; duration: 300 }
        }
    ]

    MouseArea {
        id: mouseArea
        anchors.fill: parent
    }
}
