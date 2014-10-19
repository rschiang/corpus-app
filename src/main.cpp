#include <QtGui/QGuiApplication>
#include <QQmlApplicationEngine>

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);
    app.setApplicationName("Corpus");
    app.setOrganizationName("NTUOSC");
    app.setOrganizationDomain("ntuosc.org");

    QQmlApplicationEngine engine;
    engine.load(QUrl("qrc:/main.qml"));

    return app.exec();
}
