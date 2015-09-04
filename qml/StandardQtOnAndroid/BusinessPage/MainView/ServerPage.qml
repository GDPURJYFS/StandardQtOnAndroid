import QtQuick 2.0
import Sparrow 1.0
import QtQuick.Layouts 1.1
import QtQuick.Controls 1.2

Page {
    id: page
    title: "服务窗口"
    topBar: TopBar {
        backgroundColor: "black"
        RowLayout {
            anchors.fill: parent
            SampleLabel {
                Layout.alignment: Qt.AlignCenter
                text: title
                color: "white"
            }
        }
    }
}
