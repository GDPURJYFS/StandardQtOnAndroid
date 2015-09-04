import QtQuick 2.0
import QtQuick.Layouts 1.1
import Sparrow 1.0

Rectangle {
    id: rowIconLabel

    default property alias data: rowLayout.data

    property alias iconSource: icon.source
    property alias labelText: label.text
    width: parent.width + 2
    height: 60

    border.color: "#ccc"
    border.width: 1

    RowLayout {
        id: rowLayout
        anchors.fill: parent
        spacing: 10

        Image {
            id: icon
            Layout.leftMargin: rowIconLabel.height * 0.3
            width: rowIconLabel.height * 0.45
            height: rowIconLabel.height * 0.45
            sourceSize: Qt.size(width, height)
        }

        SampleLabel {
            id: label
            width: rowIconLabel.width * 0.5
            elide: Text.ElideRight
        }
    }
}
