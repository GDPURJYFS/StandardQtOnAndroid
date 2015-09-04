import QtQuick 2.0
import QtQuick.Layouts 1.1
import QtQuick.Controls 1.2
import QtQml.Models 2.2
import Sparrow 1.0
import "./Component"
import "./BusinessPage/MainView"

Page {
    id: mainView
    color: "#aaa"

    property var textName: [page0.title, page1.title, page2.title, page3.title]

    bottomBar: BottomBar {
        RowLayout {
            Repeater {
                model: 4
                Button {
                    text: textName[index]
                    onClicked: {
                        mainListView.currentIndex = index;
                    }
                }
            }
        }
    }

    ListView {
        id: mainListView
        anchors.fill: parent
        preferredHighlightBegin: 0
        preferredHighlightEnd: 0
        //        interactive: false
        highlightMoveDuration: 250 // 0
        highlightRangeMode: ListView.StrictlyEnforceRange
        snapMode: ListView.SnapOneItem
        boundsBehavior: ListView.StopAtBounds
        orientation: ListView.Horizontal
        model: itemsModel
        onCurrentIndexChanged: forceActiveFocus();
    }


    VisualItemModel {
        id: itemsModel

        ZhiFuBaoPage {
            id: page0
            width: mainListView.width
            height: mainListView.height
        }

        ServerPage {
            id: page1
            width: mainListView.width
            height: mainListView.height
        }

        ExplorePage {
            id: page2
            width: mainListView.width
            height: mainListView.height
        }

        WealthPage {
            id: page3
            width: mainListView.width
            height: mainListView.height
        }
    }
}
