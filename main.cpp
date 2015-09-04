#include <QApplication>
#include <QQmlApplicationEngine>
#include "common-utility/qmlnetworkaccessmanagerfactory.h"

int main(int argc, char *argv[])
{
    QApplication app(argc, argv);

    //! [0]
    app.setApplicationName("StandardQtOnAndroid");
    app.setOrganizationDomain("github.com/GDPURJYFS");
    app.setOrganizationName("GDPURJYFS");
    app.setApplicationVersion("0.1.0");
    //! [0]

    //! [1] register qml type
    //! [1]

    QQmlApplicationEngine engine;

    //! [2] before loaded qml file, set the engine.
    QmlNetworkAccessManagerFactory *factory = new QmlNetworkAccessManagerFactory;
    engine.setNetworkAccessManagerFactory(factory);
    engine.addImportPath("qrc:/qml/StandardQtOnAndroid");
    //! [2]

    engine.load(QUrl(QStringLiteral("qrc:/qml/StandardQtOnAndroid/main.qml")));

    //! [3] get/set the qml root context
    //! [3]

    int r = app.exec();

    //! [end] application end
    delete factory;
    //! [end]

    return r;
}
