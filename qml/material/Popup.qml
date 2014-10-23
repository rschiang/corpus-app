import QtQuick 2.0

Rectangle {
    id: popup
    anchors {
        fill: parent
        margins: -1
    }
    state: "hidden"

    property bool dim: true

    signal backgroundClicked

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        enabled: (background.opacity > 0)
    }

    Rectangle {
        id: background
        anchors.fill: parent
        color: popup.dim ? "#aa000000" : "transparent"
        opacity: 0
    }

    states: [
        State {
            name: "visible"
            PropertyChanges { target: background; opacity: 1 }
        },
        State {
            name: "hidden"
            PropertyChanges { target: background; opacity: 0 }
        }
    ]

    transitions: [
        Transition {
            NumberAnimation {
                target: background
                property: "opacity"
                duration: 200
                easing.type: Easing.Bezier; easing.bezierCurve: [0.4, 0, 0.2, 1, 1, 1]
            }
        }
    ]
}
