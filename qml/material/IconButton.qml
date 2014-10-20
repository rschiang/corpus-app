import QtQuick 2.0

Item {
    id: root
    width: 24 * dp
    height: 24 * dp

    property alias iconSource: icon.source

    signal clicked

    PaperRipple {
        id: ripple
        anchors {
            fill: undefined
            centerIn: parent
        }
        width: 40 * dp
        height: 40 * dp
        radius: 20 * dp
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
