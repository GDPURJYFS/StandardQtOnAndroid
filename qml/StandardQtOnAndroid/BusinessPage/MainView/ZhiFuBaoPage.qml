import QtQuick 2.0
import Sparrow 1.0
import QtQuick.Layouts 1.1
import QtQuick.Controls 1.2

Page {
    id: page
    title: "支付宝"
    topBar: TopBar {
        backgroundColor: "black"
        RowLayout {
            anchors.fill: parent
            SampleLabel {
                anchors.horizontalCenter: parent.horizontalCenter
                text: title
                color: "white"
            }
            SampleLabel {
                Layout.alignment: Qt.AlignRight
                text: "账单"
                color: "white"
                MouseArea {
                    anchors.fill: parent
                    onPressed: {
                        if(Qt.colorEqual(parent.color, "white")) {
                            parent.color = "#777";
                        } else {
                            parent.color = "white";
                        }
                    }
                    onReleased: {
                        if(Qt.colorEqual(parent.color, "white")) {
                            parent.color = "#777";
                        } else {
                            parent.color = "white";
                        }
                    }
                    onClicked: {
                        console.log("打开账单")
                    }
                }
            }
        }
    } // topBar

    Rectangle {
        id: headerArea0
        width: parent.width
        height: 200
        color: "#512323"
        Row {
            anchors.fill: parent
            Rectangle {
                color: "transparent"
                width: parent.width / 2
                height: parent.height
                SampleLabel {
                    text: "扫一扫"
                    anchors.centerIn: parent
                }
            }
            Rectangle {
                width: parent.width / 2
                height: parent.height
                color: "transparent"
                SampleLabel {
                    text: "付款二维码"
                    anchors.centerIn: parent
                }
            }
        }
    } // header area

    GridView {
        id: gridView
        clip: true
        anchors.topMargin: headerArea0.height
        anchors.fill: parent
        cellWidth: parent.width / 4
        cellHeight: parent.width / 4
        delegate: Rectangle {
            width: gridView.cellWidth
            height: gridView.cellHeight
            border.color: "#ccc"
            border.width: 1
            color: Qt.rgba(Math.random(), Math.random(), Math.random(), Math.random())
        }
        model: 32
    }
}
