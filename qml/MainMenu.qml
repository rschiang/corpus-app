import QtQuick 2.0
import "material"

Menu {
    id: menu

    Rectangle {
        width: parent.width
        height: parent.width * 0.5625 + 48 * dp
        color: "#00bfa5"

        Text {
            anchors {
                left: parent.left
                right: parent.right
                bottom: parent.bottom
                margins: 16 * dp
            }
            font.family: UIConstants.sansFontFamily
            font.pointSize: UIConstants.display1FontSize
            color: "white"
            text: "Corpus"
        }
    }

    Item {
        width: parent.width
        height: 8 * dp
    }

    FlatButton {
        width: parent.width
        height: 48 * dp
        text: "意見回饋"
        onClicked: Qt.openUrlExternally("http://goo.gl/forms/iJiDkk4C6p")
    }

    FlatButton {
        width: parent.width
        height: 48 * dp
        text: "結束"
        onClicked: Qt.quit()
    }
}
