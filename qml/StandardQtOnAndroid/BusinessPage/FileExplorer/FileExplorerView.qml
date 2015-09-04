import QtQuick 2.0
import Sparrow 1.0
import QtQuick.Controls 1.2
import QtQuick.Layouts 1.1

Page {
    id: view
    title: "File Explorer"

    signal select(var fileUrls)

    Keys.onBackPressed: {
        event.accepted = true;
        if(_stackView.depth > 1) {
            _stackView.pop();
        } else {
            stackView.pop();
        }
    }
    Keys.onPressed: {
        if(event.key == Qt.Key_Backspace) {
            event.accepted = true;
            if(_stackView.depth > 1) {
                _stackView.pop();
            } else {
                stackView.pop();
            }
        }
    }


    property alias folder: fileExplorerPage.folder
    property alias nameFilters: fileExplorerPage.nameFilters
    property alias rootFolder: fileExplorerPage.rootFolder
    property alias showDirs: fileExplorerPage.showDirs
    property alias showDirsFirst: fileExplorerPage.showDirsFirst
    property alias showDotAndDotDot: fileExplorerPage.showDotAndDotDot
    property alias showFiles: fileExplorerPage.showFiles
    property alias showHidden: fileExplorerPage.showHidden
    property alias showOnlyReadable: fileExplorerPage.showOnlyReadable
    property alias sortField: fileExplorerPage.sortField
    property alias sortReversed: fileExplorerPage.sortReversed

    topBar: TopBar {
        RowLayout {
            Button {
                text: "退出"
                onClicked: stackView.pop();
            }
            SampleLabel {
                Layout.fillWidth: true
                text: _stackView.currentItem ? _stackView.currentItem.title : ""
                elide: Text.ElideRight
                color: "white"
                onTextChanged: {
                    doLayout()
                }
            }

            Button {
                Layout.alignment: Qt.AlignRight
                text: "选项"
            }
        }
    }

    StackView {
        id: _stackView
        anchors.fill: parent
        signal select(var fileUrls)
        initialItem: FileExplorerPage {
            id: fileExplorerPage
            stackView: _stackView
        }

        onSelect: view.select(fileUrls);

        function exitSelectFile() {
            stackView.pop();
        }
    }
}

