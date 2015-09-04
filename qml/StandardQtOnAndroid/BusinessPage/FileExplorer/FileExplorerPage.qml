import QtQuick 2.0
import Sparrow 1.0
import QtQuick.Layouts 1.1
import QtQuick.Controls 1.2
import QtQuick.Controls.Styles 1.2
import QtQuick.Dialogs 1.2
import Qt.labs.folderlistmodel 2.1

Page {
    id: page


    focus: true

    title: folder

    signal select(var fileUrls)

    property bool selecting: false

    readonly property alias count: folderModel.count
    property alias folder: folderModel.folder
    property alias nameFilters: folderModel.nameFilters
    readonly property alias parentFolder: folderModel.parentFolder
    property alias rootFolder: folderModel.rootFolder
    property alias showDirs: folderModel.showDirs
    property alias showDirsFirst: folderModel.showDirsFirst
    property alias showDotAndDotDot: folderModel.showDotAndDotDot
    property alias showFiles: folderModel.showFiles
    property alias showHidden: folderModel.showHidden
    property alias showOnlyReadable: folderModel.showOnlyReadable
    property alias sortField: folderModel.sortField
    property alias sortReversed: folderModel.sortReversed

    bottomBar: BottomBar {
        backgroundColor: "red"
        RowLayout {
            Button {
                text: "向上"
                onClicked: stackView.pop();
            }
            Button {
                text: !selecting ? "多选":"退出多选"
                onClicked: {
                    selecting = !selecting;
                }
            }
            Button {
                text: selectAll?"全选":"取消全选"
                visible: selecting
                property bool selectAll: true
                onClicked: {
                    helperModel.selectAll(selectAll);
                    selectAll = !selectAll;
                }
            }

            Button {
                text: "完成"
                visible: selecting
                onClicked: {
                    var iter = 0, fileUrls = [];
                    busy.show();
                    console.time("e")
                    for(iter; iter<folderModel.count; iter++) {
                        if(helperModel.get(iter).checked) {
                            fileUrls.push(folderModel.get(iter, "fileURL"));
                        }
                    }
                    console.timeEnd("e")
                    busy.close();
                    console.log("FileExplorer :");
                    page.select(fileUrls);
                    stackView.exitSelectFile();
                }
            }
        }
    }

    onSelect: stackView.select(fileUrls);

    FolderListModel {
        id: folderModel
        showDotAndDotDot: false
        sortField: FolderListModel.Type
        showDirsFirst: true
        showHidden: false
        onCountChanged: {
            var iter = 0;
            helperModel.clear();
            while(iter++ < count) {
                helperModel.append({"checked": false});
            }
        }
    }

    ListModel {
        id: helperModel
        function selectAll(flag) {
            for(var iter=0; iter < helperModel.count; iter++) {
                helperModel.setProperty(iter, "checked", flag);
            }
        }

        //        ListElement {
        //            checkable: false
        //        }
    }


    Component {
        id: fileDelegate

        Rectangle {
            width: listView.width
            height: fileInfo.implicitHeight * 1.2
            color: "#eee"
            border.width: 1
            border.color: "#ccc"

            RowLayout {
                anchors.fill: parent

                CheckBox {
                    id: checkBox
                    Layout.leftMargin: 10
                    visible: selecting
                    checked: helperModel.get(index).checked
                }

                Image {
                    Layout.leftMargin: 10
                    width: fileInfo.implicitHeight
                    height: fileInfo.implicitHeight
                    sourceSize: Qt.size(width, height)
                    source: fileIsDir? "./file-icon/dir.png": getFileIcon(fileSuffix)
                }

                ColumnLayout {
                    id: fileInfo
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    SampleLabel {
                        Layout.fillWidth: true
                        text: fileName
                        elide: Text.ElideRight
                    }
                    SampleLabel {
                        Layout.fillWidth: true
                        text: fileModified
                        elide: Text.ElideRight
                    }
                }
            }
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    if(!selecting) {
                        if(fileIsDir && folderModel.folder != fileURL) {
                            // console.log(fileURL);
                            __PushPage(Qt.resolvedUrl("./FileExplorerPage.qml")
                                       ,{
                                           folder: fileURL

                                           ,nameFilters:   nameFilters
                                           //                                           ,parentFolder:   parentFolder
                                           //                                           ,rootFolder:   rootFolder
                                           ,showDirs:   showDirs
                                           ,showDirsFirst:   showDirsFirst
                                           ,showDotAndDotDot:   showDotAndDotDot
                                           ,showFiles:   showFiles
                                           ,showHidden:   showHidden
                                           ,showOnlyReadable: showOnlyReadable
                                           ,sortField: sortField
                                           ,sortReversed:   sortReversed
                                       }
                                       );
                        }
                    }else {
                        helperModel.setProperty(index, "checked", !checkBox.checked)
                    }
                }
                onPressed: parent.color = "#ddd"
                onReleased: parent.color = "#eee"
                onPositionChanged: parent.color = "#eee"
                onPressAndHold: {
                    selecting = true;
                }
            }
        }
    }   // fileDelegate

    ListView {
        id: listView
        anchors.fill: parent
        focus: true

        add: Transition {
            NumberAnimation { properties: "x,y"; from: 100; duration: 500 }
        }
        addDisplaced: Transition {
            NumberAnimation { properties: "x,y"; duration: 500 }
        }
        move: Transition {
            NumberAnimation { properties: "x,y"; duration: 500 }
        }
        moveDisplaced: Transition {
            NumberAnimation { properties: "x,y"; duration: 500 }
        }

        model: folderModel
        delegate: fileDelegate
    }

    Rectangle {
        id: busy
        anchors.fill: parent
        visible: false
        color: Qt.rgba(0.5, 0.5, 0.5, 0.5)
        BusyIndicator {
            running: parent.visible
            anchors.centerIn: parent
        }
        function show() {
            busy.visible = true;
        }
        function close() {
            busy.visible = false;
        }
    }

    function exitisItemInList(list, item) {
        for(var iter in list) {
            if(item == list[iter]) {
                return true;
            }
        }
        return false;
    }

    function getFileIcon(fileSuffix) {

        var suffix = String(fileSuffix).toLocaleLowerCase();
        var picSuffixs = ["bmp","gif","jpg","jpeg","png"
                          ,"pbm","pgm","ppm", "xbm","xpm", "svg"];
        var wordSuffixs = ["doc","docx"];
        var execlSuffixs = ["xls","xlsx"];
        var musicSuffixs = ["mp3","flac","ape"];
        var soundSuffixs = ["wav"];
        var textSuffixs = ["txt","cpp","h","c","qml","pro","qmlproject","java"];
        var zipSuffixs = ["zip","rar","tar.gz","tar.bz2","tar.xz","7z","lzh"];

        if(exitisItemInList(picSuffixs, suffix)) {
            return "./file-icon/picture.png";
        }

        if(exitisItemInList(wordSuffixs, suffix)) {
            return "./file-icon/word.png";
        }

        if(exitisItemInList(execlSuffixs,suffix)) {
            return "./file-icon/excel.png"
        }

        if(exitisItemInList(musicSuffixs,suffix)) {
            return "./file-icon/music.png"
        }

        if(exitisItemInList(soundSuffixs, suffix)) {
            return "./file-icon/sound.png"
        }

        if(exitisItemInList(textSuffixs, suffix)) {
            return "./file-icon/text.png"
        }

        if(exitisItemInList(zipSuffixs, suffix)) {
            return "./file-icon/zip.png"
        }

        return "./file-icon/file.png"
    }
}

