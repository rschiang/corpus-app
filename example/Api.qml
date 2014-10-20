import QtQuick 2.0

QtObject {
    id: api

    // TODO: Hook your own server UI
    property string baseUrl: "http://example.com/api/"

    function photo(path) {
        // Build image URL with relative path or ID
        return "http://lorempixel.com/640/480" + path
    }

    function posts(fn) {
        get("posts/all/", fn)
    }

    function get(path, fn) {
        var request = new XMLHttpRequest()
        request.open("GET", baseUrl + path, true)
        request.setRequestHeader("X-Requested-With", "org.ntuosc.corpus")
        request.onreadystatechange = function() {
            if (request.readyState == request.DONE && request.status == 200) {
                console.log(request.status + " " + request.statusText)
                fn(request.responseText)
            }
        }
        request.send()
    }
}
