import QtQuick 2.0
import QtGraphicalEffects 1.0

Item {
    id: root

    property int radius: 2
    property color color: "#de000000"

    Rectangle {
        id: background
        anchors.fill: parent
        color: root.enabled ? "white" : "#eaeaea"
        radius: root.radius
        visible: false
    }

    PaperShadow {
        id: shadow
        anchors.fill: parent
        source: background
        depth: root.enabled ? (mouseArea.pressed ? 2 : 1) : 0
    }

    Rectangle {
        id: rippleContainer
        anchors.fill: parent
        color: "#00ffffff"
        radius: root.radius
        clip: true
    }

    Component {
        id: ripple

        Rectangle {
            id: ink
            radius: 0
            opacity: 0.25
            color: root.color
            property int startX
            property int startY
            property int maxRadius: 150

            x: startX - radius
            y: startY - radius
            width: radius * 2
            height: radius * 2

            NumberAnimation {
                id: growAnimation
                target: ink; property: "radius"; from: 0; to: maxRadius; duration: 1100
                easing.type: Easing.OutCubic
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

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        enabled: root.enabled
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
