import QtQuick 2.0
import QtPositioning 5.2
import "material"
import "Cache.js" as Cache

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
            visible: !field.length && !field.inputMethodComposing
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

        Keys.onPressed: {
            if (event.key == Qt.Key_Return) {
                if (text.length > 12 && text.charAt(text.length - 1) == "\n") {
                    event.accepted = true
                    text = text.trim()
                    send()
                }
            }
        }

        Keys.onReleased: {
            if (event.key == Qt.Key_Back || event.key == Qt.Key_Escape) {
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
                enabled: false
            }

            IconButton {
                id: locationButton
                anchors {
                    left: cameraButton.right
                    leftMargin: 16 * dp
                    verticalCenter: parent.verticalCenter
                }

                property bool active: true

                iconSource: (enabled && active) ? "qrc:/assets/icon_location-colored" : "qrc:/assets/icon_location"
                enabled: position.supportedPositioningMethods != PositionSource.NoPositioningMethods
                onClicked: active = !active

                PositionSource {
                    id: position
                    active: dialog.active && Qt.application.state == Qt.ApplicationActive
                    updateInterval: 2000
                    preferredPositioningMethods: PositionSource.SatellitePositioningMethods
                    onPositionChanged: Cache.updateLocation(position.position)
                }
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
                onClicked: send()
            }
        }
    }

    onOpening: {
        field.focus = true
        locationButton.active = (Cache.settings.positioning !== "off")
    }

    onClosing: {
        field.focus = false
        field.text = ""
        if (position.active)
            position.stop()
        database.set("positioning", locationButton.active ? "on" : "off")
    }

    onBackgroundClicked: {
        dialog.close()
    }

    function send() {
        var coordinate = {latitude: 25.02, longitude: 121.54}
        if (locationButton.active) {
            var pos = Cache.findBestLocation()
            if (pos)
                coordinate = pos
            else if (position.valid) {
                coordinate.latitude = position.position.coordinate.latitude
                coordinate.longitude = position.position.coordinate.longitude
            }
        }

        api.submitPost(field.text, coordinate, function(e) {
            mainView.load()
        })
        dialog.close()
    }
}
