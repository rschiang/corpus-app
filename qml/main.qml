import QtQuick 2.0
import QtQuick.Window 2.0

Window {
    id: root
    width: Screen.width
    height: Screen.height
    visible: true
    title: "Corpus"
    color: "#eee"

    property real dp: 1.5 //Math.max(0.5, Screen.pixelDensity * 25.4 / 160)
    property string platformFont: "Roboto"

    MainView {
    }

    Api {
        id: api
    }
}
