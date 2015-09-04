import QtQuick 2.5
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.2
import Sparrow 1.0

Page {
    title: qsTr("Settings")

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
                text: qsTr("Save")
                onClicked: {
                    save();
                    stackView.pop();
                }
            }
        }
    }

    function save() {
        ApplicationSettings.setNormalFontPointSize(Number(fontPointSizeInput.text));
        ApplicationSettings.setFontFamily(fontFamilyInput.currentText);
        ApplicationSettings.setGridViewBufferBlock(gridViewBufferBlock.text);
    }

    ColumnLayout {
        anchors.fill: parent

        GroupBox {
            id: gridBox
            title: "Grid layout"
            Layout.fillWidth: true

            GridLayout {
                id: gridLayout
                rows: 4
                flow: GridLayout.TopToBottom
                anchors.fill: parent

                Label { text: qsTr("font pointSize")}
                Label { text: qsTr("font family") }
                Label { text: qsTr("grid view buffer block") }

                Button {
                    text: "reset"
                    onClicked: {
                        ApplicationSettings.resetFontFamily();
                        fontFamilyInput.currentIndex =
                                fontFamilyInput.find(ApplicationSettings.fontFamily);

                        ApplicationSettings.resetNormalFontPointSize();
                        fontPointSizeInput.text = ApplicationSettings.defaultNormalFontPointSize;

                        ApplicationSettings.resetGridViewBufferBlock();
                        gridViewBufferBlock.text = ApplicationSettings.gridViewBufferBlock;
                    }
                }

                TextField {
                    id: fontPointSizeInput
                    text: ApplicationSettings.defaultNormalFontPointSize
                    validator: IntValidator {
                        top: 1000
                        bottom: 1
                    }
                }

                ComboBox {
                    id: fontFamilyInput
                    editable: true
                    model: Qt.fontFamilies()

                    Component.onCompleted:
                        fontFamilyInput.currentIndex =
                        fontFamilyInput.find(ApplicationSettings.fontFamily);
                }

                TextField {
                    id: gridViewBufferBlock
                    text: ApplicationSettings.gridViewBufferBlock
                    validator: IntValidator {
                        top: 100
                        bottom: 10
                    }
                }


                CheckBox {
                    text: "defaultPageEnablePush"
                    checked: ApplicationSettings.defaultPageEnablePush
                    onClicked: {
                        ApplicationSettings.setPageEnablePush(checked)
                        console.log(ApplicationSettings.defaultPageEnablePush)
                    }
                }

            }
        }
    }
}

