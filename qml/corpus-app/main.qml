import QtQuick 2.0
import QtGraphicalEffects 1.0

Rectangle {
    width: 450
    height: 800
    color: "#eee"

    Card {
        anchors.centerIn: parent
        width: 240
        height: 100
        radius: 3

        Text {
            anchors.centerIn: parent
            font.family: "Roboto"
            font.capitalization: Font.AllUppercase
            font.pixelSize: 34
            renderType: Text.NativeRendering
            text: "ACCEPT"
        }
    }
}
