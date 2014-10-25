import QtQuick 2.0
import "material"

Dialog {
    id: dialog

    TextEdit {
        id: field
        width: parent.width
        height: Math.min(Math.max(field.implicitHeight, 168 * dp), root.height - 132 * dp)
        textMargin: 24 * dp

        color: "#de000000"
        font.family: UIConstants.sansFontFamily
        font.pointSize: UIConstants.subheadFontSize

        Behavior on height {
            NumberAnimation {
                duration: 200
                easing.type: Easing.Bezier; easing.bezierCurve: [0.4, 0, 0.2, 1, 1, 1]
            }
        }
    }

    Item {
        width: parent.width
        height: 52 * dp

        Item {
            id: actions
            anchors {
                fill: parent
                leftMargin: 16 * dp
                rightMargin: 16 * dp
                bottomMargin: 16 * dp
            }

            IconButton {
                id: cameraButton
                anchors {
                    left: parent.left
                    verticalCenter: parent.verticalCenter
                }
                iconSource: "qrc:/assets/icon_camera"
            }

            IconButton {
                id: locationButton
                anchors {
                    left: cameraButton.right
                    leftMargin: 16 * dp
                    verticalCenter: parent.verticalCenter
                }
                iconSource: "qrc:/assets/icon_location"
            }

            FlatButton {
                id: sendButton
                anchors {
                    right: parent.right
                    verticalCenter: parent.verticalCenter
                }
                text: "Send"
                textColor: "#795548"
                onClicked: dialog.close()
            }
        }
    }
}
