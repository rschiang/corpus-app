#include <QtGui/QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QScreen>

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);
    app.setApplicationName("Corpus");
    app.setOrganizationName("NTUOSC");
    app.setOrganizationDomain("ntuosc.org");

    QQmlApplicationEngine engine;
    qreal dp = QGuiApplication::primaryScreen()->physicalDotsPerInch() / 160.0;
    engine.rootContext()->setContextProperty("dp", dp);
    engine.load(QUrl("qrc:/main.qml"));

    return app.exec();
}
