import QtQuick 2.0
import "material"

Menu {
    id: menu

    Image {
        width: parent.width
        height: parent.width * 0.5625
        fillMode: Image.PreserveAspectFit
        source: "qrc:/assets/intro"

        IconButton {
            id: backButton
            x: 16 * dp
            y: 16 * dp

            rippleColor: "#deffffff"
            iconSource: "qrc:/assets/icon_back"
            onClicked: menu.close()
        }

        Text {
            anchors {
                left: parent.left
                right: parent.right
                bottom: parent.bottom
                margins: 16 * dp
            }
            font.family: UIConstants.sansFontFamily
            font.pointSize: UIConstants.headlineFontSize
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

    onOpening: menu.focus = true
    onClosing: menu.focus = false
    Keys.onReleased: {
        if (event.key == Qt.Key_Back) {
            event.accepted = true
            dialog.close()
        }
    }
}
