import QtQuick 2.0
import "."

Popup {
    id: popup

    default property alias dialogChildren: layout.children

    Item {
        id: menu
        anchors {
            fill: parent
            rightMargin: 56 * dp
        }
        state: popup.state
        transform: Translate { id: menuTranslate }

        PaperShadow {
            id: shadow
            anchors.fill: background
            source: background
            depth: 4
        }

        Rectangle {
            id: background
            anchors.fill: parent
            color: "#fafafa"
            visible: false
        }

        MouseArea {
            id: eventEater
            anchors.fill: parent
            enabled: (popup.state == "visible")
        }

        Column {
            id: layout
            width: parent.width
        }

        states: [
            State {
                name: "visible"
                PropertyChanges { target: menuTranslate; x: 0 }
            },
            State {
                name: "hidden"
                PropertyChanges { target: menuTranslate; x: -menu.width }
            }
        ]

        transitions: [
            Transition {
                NumberAnimation {
                    target: menuTranslate
                    property: "x"
                    duration: 200
                    easing.type: Easing.Bezier; easing.bezierCurve: [0.4, 0, 0.2, 1, 1, 1]
                }
            }
        ]
    }

    onBackgroundClicked: {
        popup.close()
    }
}
