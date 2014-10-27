.pragma library

var posts = {}
var coordinates = []

function setPost(id, value) {
    posts[id] = value
}

function getPost(id) {
    return posts[id]
}

function containsPost(id) {
    return (id in posts)
}

function updateLocation(pos) {
    var coord = pos.coordinate
    var accuracy = (pos.horizontalAccuracyValid) ?
        Math.max((pos.verticalAccuracyValid ? pos.verticalAccuracy : 0), pos.horizontalAccuracy) :
        (pos.verticalAccuracyValid ? pos.verticalAccuracy : Number.MAX_VALUE)

    var record = { timestamp: new Date().getTime(), latitude: coord.latitude, longitude: coord.longitude, accuracy: accuracy }
    coordinates.push(record)
    console.log(JSON.stringify(record))
}

function findBestLocation() {
    var now = new Date().getTime()
    var index = -1

    for (var i in coordinates) {
        if ((now - coordinates[i].timestamp) < 300000)
            if (index >= 0 && coordinates[index].accuracy > coordinates[i].accuracy)
                index = i;
    }

    return (index >= 0) ? coordinates[i] : false
}
