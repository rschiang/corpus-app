import QtQuick 2.0
import QtGraphicalEffects 1.0

Rectangle {
    width: 450
    height: 800
    color: "#eee"

    Card {
        anchors.centerIn: parent
        width: 100
        height: 100

        Text {
            anchors.centerIn: parent
            text: "Hello"
        }
    }
}
