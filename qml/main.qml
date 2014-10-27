import QtQuick 2.0
import QtQuick.Window 2.2

Window {
    id: root
    visible: true
    visibility: Window.Maximized
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
