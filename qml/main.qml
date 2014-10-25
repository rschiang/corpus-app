import QtQuick 2.0
import QtQuick.Window 2.0

Window {
    id: root
    width: Screen.width
    height: Screen.height
    visible: true
    title: "Corpus"
    color: "#eee"

    MainView {
        id: mainView
    }

    PostView {
        id: postView
    }

    PostDialog {
        id: postDialog
    }

    Api {
        id: api
    }
}
