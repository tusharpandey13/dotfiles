import QtQuick 2.15

Rectangle {
    id: root
    property int number
    property alias font: text.font.family
    radius: height *  0.05

    color: "#0f0f0f"

    Text {
        id: text
        text:  (root.number < 10 ? "0" : "") + root.number
        anchors.fill: parent
        color: "#b7b7b7"
        font.pixelSize: Math.min(height * 0.8, width * 0.8)
        font.family: fixedFont.name
        renderType: Text.QtRendering
        horizontalAlignment:  Text.AlignHCenter
        verticalAlignment:  Text.AlignVCenter
    }
}
