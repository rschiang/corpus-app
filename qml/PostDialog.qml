import QtQuick 2.0
import "material"

Dialog {
    id: dialog

    TextEdit {
        id: field
        width: parent.width
        height: Math.min(Math.max(field.implicitHeight, 168 * dp), root.height - 132 * dp)
        textMargin: 24 * dp
        wrapMode: Text.Wrap

        color: "#de000000"
        selectionColor: "#a1887f"
        selectedTextColor: color
        font.family: UIConstants.sansFontFamily
        font.pointSize: UIConstants.subheadFontSize

        Text {
            id: placeholder
            anchors {
                fill: parent
                margins: field.textMargin
            }
            visible: !field.length
            color: "#8a999999"
            font: field.font
            text: "周圍有什麼新鮮事？"
        }

        Behavior on height {
            NumberAnimation {
                duration: 200
                easing.type: Easing.Bezier; easing.bezierCurve: [0.4, 0, 0.2, 1, 1, 1]
            }
        }

        Keys.onReleased: {
            if (event.key == Qt.Key_Back) {
                event.accepted = true
                dialog.close()
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
                    top: parent.top
                    bottom: parent.bottom
                    right: parent.right
                    rightMargin: -16 * dp
                }
                text: "傳送"
                textColor: "#795548"
                enabled: (field.length >= 12)
                onClicked: {
                    api.submitPost(field.text, {latitude: 25.02, longitude: 121.54}, function(e) {
                        mainView.load()
                    })
                    dialog.close()
                }
            }
        }
    }

    onOpening: {
        field.focus = true
    }

    onClosing: {
        field.focus = false
        field.text = ""
    }

    onBackgroundClicked: {
        dialog.close()
    }
}
