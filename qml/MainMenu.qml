import QtQuick 2.0
import "material"

Menu {
    id: menu

    Image {
        width: parent.width
        height: parent.width * 0.5625
        sourceSize.width: 320 * dp
        sourceSize.height: 320 * dp
        fillMode: Image.PreserveAspectFit
        source: "qrc:/assets/intro"

        Rectangle {
            anchors {
                left: parent.left
                right: parent.right
                bottom: parent.bottom
            }
            height: 56 * dp
            gradient: Gradient {
                GradientStop { position: 0; color: "#00000000" }
                GradientStop { position: 1; color: "#33000000" }
            }
        }

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
        text: "版本 " + api.version
        enabled: false
    }

    MenuItemSeparator {}

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
