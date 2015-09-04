import QtQuick 2.0
import Sparrow 1.0
import QtMultimedia 5.4
import QtQuick.Controls 1.2
import QtQuick.Dialogs 1.2
import QtQuick.Layouts 1.1

Page {
    color: "black"

    Keys.onBackPressed: {
        event.accepted = true;
        stackView.pop();
    }
    Keys.onPressed: {
        if(event.key == Qt.Key_Backspace) {
            event.accepted = true;
            stackView.pop();
        }
    }
    topBar: TopBar {
        RowLayout {
            anchors.fill: parent
            Button {
                text: qsTr("Back")
                onClicked: {
                    stackView.pop();
                }
            }
            Button {
                Layout.alignment: Qt.AlignRight
                text: qsTr("select file")
                onClicked: {
                    fileDialog.open();
                }
            }
        }
    }

    Video {
        id: video
        anchors.fill: parent
        MouseArea {
            anchors.fill: parent
            onClicked: {
                video.playbackState == MediaPlayer.PlayingState ? video.pause() : video.play();
            }
        }
    }

    FileDialog {
        id: fileDialog
        onAccepted: {
            console.log(fileDialog.fileUrl);
            video.source = fileDialog.fileUrl;
            video.play();
        }
    }
}

