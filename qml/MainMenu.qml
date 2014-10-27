import QtQuick 2.0
import "material"

Menu {
    id: menu

    Image {
        width: parent.width
        height: parent.width * 0.5625
        fillMode: Image.PreserveAspectFit
        source: "qrc:/assets/intro"

        Text {
            anchors {
                left: parent.left
                right: parent.right
                bottom: parent.bottom
                margins: 16 * dp
            }
            font.family: UIConstants.sansFontFamily
            font.pointSize: UIConstants.titleFontSize
            color: "white"
            text: "Corpus"
        }
    }

    MenuItemSeparator {
        height: 8 * dp
    }

    MenuItem {
        text: "意見回饋"
        onClicked: Qt.openUrlExternally("http://goo.gl/forms/iJiDkk4C6p")
    }

    MenuItem {
        text: "結束"
        onClicked: Qt.quit()
    }
}
