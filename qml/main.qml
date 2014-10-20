import QtQuick 2.0
import QtQuick.Window 2.0

Window {
    id: root
    width: Screen.width
    height: Screen.height
    visible: true
    title: "Corpus"
    color: "#eee"

    property real dp: Math.max(0.5, Screen.pixelDensity * 25.4 / 160)
    property string platformFont: "Roboto"

    ActionBar {
        id: actionBar
        z: 2
    }

    MainView {
        anchors.topMargin: actionBar.height
    }

    Api {
        id: api
    }
}
