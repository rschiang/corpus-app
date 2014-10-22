import QtQuick 2.0
import "."

Item {
    id: button
    width: Math.max(88 * dp, label.paintedWidth + 32 * dp)
    height: 36 * dp

    property alias text: label.text

    signal clicked

    Rectangle {
        id: background
        anchors.fill: parent
        radius: 3 * dp
        color: button.enabled ? "white" : "#eaeaea"
        visible: false
    }

    PaperShadow {
        id: shadow
        source: background
        depth: button.enabled ? (mouseArea.pressed ? 3 : 1) : 0
    }

    Text {
        id: label
        anchors.centerIn: parent
        font.family: UIConstants.sansFontFamily
        font.pointSize: UIConstants.bodyFontSize
        font.bold: Font.DemiBold
        font.capitalization: Font.AllUppercase
        color: UIConstants.bodyTextColor
    }

    PaperRipple {
        id: ripple
        radius: 3 * dp
        mouseArea: mouseArea
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        enabled: button.enabled
        onClicked: button.clicked()
    }
}
