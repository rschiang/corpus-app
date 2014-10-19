import QtQuick 2.0

Item {
    id: root
    width: 56 * dp
    height: 56 * dp

    property alias color: background.color
    property alias iconSource: icon.source

    signal clicked

    Rectangle {
        id: background
        anchors.fill: parent
        radius: 28 * dp
        visible: false
    }

    PaperShadow {
        id: shadow
        source: background
        depth: root.enabled ? (mouseArea.pressed ? 5 : 3) : 0
    }

    PaperRipple {
        id: ripple
        radius: 28 * dp
        color: "#deffffff"
        mouseArea: mouseArea
    }

    Image {
        id: icon
        anchors.centerIn: parent
        width: 24 * dp
        height: 24 * dp
        sourceSize.width: width
        sourceSize.height: height
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        enabled: root.enabled
        onClicked: root.clicked()
    }
}
