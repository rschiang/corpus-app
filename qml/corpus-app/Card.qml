import QtQuick 2.0
import QtGraphicalEffects 1.0

Item {
    id: root

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

        color: "#3d000000"
        horizontalOffset: 0
        verticalOffset: 1
        radius: 1.0
        spread: 0.0
        samples: 32
        transparentBorder: true
    }

    ParallelAnimation {
        id: pressedAnimation
        ColorAnimation { target: topShadow; to: "#50000000"; duration: 200; }
        ColorAnimation { target: bottomShadow; to: "#3a000000"; duration: 200; }
        SmoothedAnimation { target: topShadow; property: "verticalOffset"; to: 10; duration: 200; }
        SmoothedAnimation { target: topShadow; property: "radius"; to: 10; duration: 200; }
        SmoothedAnimation { target: bottomShadow; property: "verticalOffset"; to: 6; duration: 200; }
        SmoothedAnimation { target: bottomShadow; property: "radius"; to: 3; duration: 200; }
        SequentialAnimation {
            SmoothedAnimation { target: overlay; property: "opacity"; to: 0.4; duration: 200; easing.type: Easing.OutQuint; }
            ScriptAction { script: if (!mouseArea.pressed) releasedAnimation.start() }
        }
    }

    ParallelAnimation {
        id: releasedAnimation
        ColorAnimation { target: topShadow; to: "#1e000000"; duration: 500; }
        ColorAnimation { target: bottomShadow; to: "#3d000000"; duration: 500; }
        SmoothedAnimation { target: overlay; property: "opacity"; to: 0; duration: 500; }
        SmoothedAnimation { target: topShadow; property: "verticalOffset"; to: 1; duration: 500; }
        SmoothedAnimation { target: topShadow; property: "radius"; to: 1.5; duration: 500; }
        SmoothedAnimation { target: bottomShadow; property: "verticalOffset"; to: 1; duration: 500; }
        SmoothedAnimation { target: bottomShadow; property: "radius"; to: 1; duration: 500; }
    }

    Rectangle {
        id: overlay
        anchors.fill: parent
        color: "#999"
        radius: 2
        opacity: 0
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        onPressed: pressedAnimation.start()
        onReleased: if (!pressedAnimation.running) releasedAnimation.start()
    }
}
