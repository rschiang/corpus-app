import QtQuick 2.0
import QtQuick.LocalStorage 2.0
import "Cache.js" as Cache

QtObject {
    id: database

    function get() {
        var db = LocalStorage.openDatabaseSync("corpus", "1.0", "settings", 1000)
        db.transaction(function(tx) {
            tx.executeSql("CREATE TABLE IF NOT EXISTS settings(key TEXT UNIQUE, value TEXT)")
        })
        return db
    }

    function set(key, value) {
        var db = database.get()
        db.transaction(function(tx) {
            tx.executeSql("INSERT OR REPLACE INTO settings (key, value) VALUES (?, ?)", [key, value])
        })
        Cache.settings[key] = value
    }

    Component.onCompleted: {
        var db = database.get()
        db.transaction(function(tx) {
            var result = tx.executeSql("SELECT * FROM settings")
            for (var i = 0; i < result.rows.length; i++) {
                var row = result.rows.items(i)
                Cache.settings[row.key] = row.value
            }

            api.load()
        })
    }
}
