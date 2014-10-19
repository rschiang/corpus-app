import QtQuick 2.0
import QtGraphicalEffects 1.0

Item {
    id: root
    state: root.enabled ? (mouseArea.pressed ? "z-2" : "z-1") : "z-0"

    Rectangle {
        id: background
        anchors.fill: parent
        color: root.enabled ? "white" : "#eaeaea"
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

    Rectangle {
        id: rippleContainer
        anchors.fill: parent
        color: "#00ffffff"
        radius: 2
        clip: true
    }

    Component {
        id: ripple

        Rectangle {
            id: ink
            radius: width
            opacity: 0.25
            color: "black"
            property int startX
            property int startY
            property int maxRadius

            ParallelAnimation {
                id: growAnimation
                NumberAnimation { target: ink; property: "x"; from: startX; to: startX - maxRadius; duration: 1100; }
                NumberAnimation { target: ink; property: "y"; from: startY; to: startY - maxRadius; duration: 1100; }
                NumberAnimation { target: ink; properties: "width,height"; from: 0; to: maxRadius * 2; duration: 1100; }
            }

            SequentialAnimation {
                id: fadeAnimation
                NumberAnimation { target: ink; property: "opacity"; from: 0.25; to: 0; duration: 312; }
                ScriptAction { script: ink.destroy() }
            }

            Connections {
                target: mouseArea
                onReleased: if (!fadeAnimation.running) fadeAnimation.start()
            }

            Component.onCompleted: {
                growAnimation.start()
                if (!(mouseArea.pressed || fadeAnimation.running))
                    fadeAnimation.start()
            }
        }
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
        onPressed: {
            var wave = ripple.createObject(rippleContainer, {
                                               startX: mouseX, startY: mouseY,
                                               maxRadius: furthestDistance(mouseX, mouseY)
                                           })
        }

        function distance(x1, y1, x2, y2) {
            return Math.sqrt(Math.pow(x1 - x2, 2) + Math.pow(y1 - y2, 2))
        }

        function furthestDistance(x, y) {
            return Math.max(distance(x, y, 0, 0), distance(x, y, width, height),
                            distance(x, y, 0, height), distance(x, y, width, 0))
        }
    }
}