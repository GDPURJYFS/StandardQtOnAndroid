import QtQuick 2.5
import QtQuick.Layouts 1.1
import QtQuick.Controls 1.2
import Sparrow 1.0

PageStackWindow {
    id: mainWindow
    title: qsTr("Hello World")
    initialPage: MainView {
        id: mainView
        Keys.onBackPressed: {
            console.log()
            Qt.quit()
        }
        Keys.onPressed: {
            if(event.key == Qt.Key_Backspace) {
                event.accepted = true;
                Qt.quit();
            }
        }
    }
}
