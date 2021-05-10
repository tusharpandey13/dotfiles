import QtQuick 2.15
import org.kde.plasma.core 2.0 as PlasmaCore

Rectangle {
    id: root
    color: "black"

    width: 1024
    height: 768

    FontLoader {
        id: fixedFont
        source: "gluqlo.ttf"
    }

    PlasmaCore.DataSource {
        id: dataSource
        engine: "time"
        connectedSources: "Local"
        interval: 60000
        intervalAlignment: PlasmaCore.Types.AlignToMinute
        onDataChanged: {
            updateTime()
        }
    }

    function updateTime() {
        root.hour = dataSource.data["Local"]["DateTime"].getHours()
        root.min = dataSource.data["Local"]["DateTime"].getMinutes()
    }

    property int hour
    property int min


    // helper for testing animation
    //Timer {
        //running: true
        //interval: 4000
        //repeat: true
        //onTriggered: root.hour++
    //}


    Digit {
        id: hours
        height: root.height * 0.6
        width: Math.min(parent.width * 0.45, height)
        anchors.right: parent.horizontalCenter
        anchors.rightMargin: parent.width * 0.01
        font: fixedFont.name
        anchors.verticalCenter: root.verticalCenter
        number: root.hour

        onNumberChanged: {
            flipEffectHours.flip()
        }
    }

    FlipEffect {
        id: flipEffectHours
        sourceItem: hours
        anchors.fill: hours
    }


    Digit {
        id: min
        height: root.height * 0.6
        width: Math.min(parent.width * 0.45, height)
        anchors.left: parent.horizontalCenter
        anchors.leftMargin: parent.width * 0.01
        font: fixedFont.name
        anchors.verticalCenter: root.verticalCenter
        number: root.min
        onNumberChanged: flipEffectMin.flip()
    }

    FlipEffect {
        id: flipEffectMin
        sourceItem: min
        anchors.fill: min
    }


}
