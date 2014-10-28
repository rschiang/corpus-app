TEMPLATE = app

TARGET = Corpus

QT += qml quick network sql svg positioning

SOURCES += src/main.cpp

RESOURCES += qml/assets.qrc

OTHER_FILES += qml/*.qml \
    qml/*.js \
    qml/material/*.qml \
    platform/android/AndroidManifest.xml

mac {
    QMAKE_INFO_PLIST = platform/mac/Info.plist
    ICON = platform/mac/icon.icns
    #QMAKE_POST_LINK += macdeployqt Corpus.app/ -qmldir=qml/ -verbose=1 -dmg
    QMAKE_MAC_SDK = macosx10.9
}

android {
    ANDROID_PACKAGE_SOURCE_DIR = $$PWD/platform/android
}
