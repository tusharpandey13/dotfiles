/********************************************************************
This file is part of the KDE project.

Copyright (C) 2012 Gregor Petrin <gregap@gmail.com>

This program is free software; you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation; either version 2 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.
*********************************************************************/
import QtQuick 1.0
import org.kde.plasma.core 0.1 as PlasmaCore
import org.kde.qtextracomponents 0.1
import org.kde.kwin 0.1 as KWin

Item {
    id: informativeTabBox
    property int screenWidth : 0
    property int screenHeight : 0
    property bool allDesktops: true
    property string longestCaption: ""
    property int imagePathPrefix: (new Date()).getTime()
    property int optimalWidth: listView.maxRowWidth
    property int optimalHeight: listView.rowHeight * listView.count 
    property bool canStretchX: true
    property bool canStretchY: false
    width: Math.min(Math.max(screenWidth * 0.2, optimalWidth), screenWidth * 0.8)
    height: Math.min(Math.max(screenHeight * 0.2, optimalHeight), screenHeight * 0.8)
    focus: true
    clip: true

    property int textMargin: 2
    
    onLongestCaptionChanged: {
        listView.maxRowWidth = listView.calculateMaxRowWidth();
    }

    function setModel(model) {
        listView.model = model;
        listView.maxRowWidth = listView.calculateMaxRowWidth();
        listView.imageId++;
    }

    function modelChanged() {
        listView.imageId++;
    }

    /**
    * Returns the caption with adjustments for minimized items.
    * @param caption the original caption
    * @param mimized whether the item is minimized
    * @return Caption adjusted for minimized state
    **/
    function itemCaption(caption, minimized) {
        var text = caption;
        if (minimized) {
            text = "(" + text + ")";
        }
        return text;
    }
    
    //Text { text: activeFocus ? "I have active focus!" : "I do not have active focus" }

    PlasmaCore.Theme {
        id: theme
    }

    // just to get the margin sizes
    PlasmaCore.FrameSvgItem {
        id: hoverItem
        imagePath: "widgets/viewitem"
        prefix: "hover"
        visible: false
    }

    // delegate
    Component {
        id: listDelegate
        Item {
            property variant myData: model
            
            id: delegateItem
            height: listView.rowHeight
            anchors.right: listDelegate.right
            width: listView.width
            
            Image {
                id: iconItem
                source: "image://client/" + index + "/" + informativeTabBox.imagePathPrefix + "-" + listView.imageId + (index == listView.currentIndex ? "/selected" : "/disabled")
                width: 32
                height: 32
                sourceSize {
                    width: 32
                    height: 32
                }
                anchors {
                    verticalCenter: parent.verticalCenter
                    left: parent.left
                    leftMargin: hoverItem.margins.left
                }
            }
            Text {
                id: captionItem
                horizontalAlignment: Text.AlignHLeft
                verticalAlignment: Text.AlignVCenter
                text: itemCaption(caption, minimized)
                font.bold: false
                font.italic: minimized
                font.pointSize: informativeTabBox.allDesktops ? 10 : 12
                color: theme.textColor
                elide: Text.ElideMiddle
                anchors {
                    left: iconItem.right
                    right: parent.right
                    top: parent.top
                    bottom: informativeTabBox.allDesktops ? null : parent.bottom
                    topMargin: informativeTabBox.textMargin + hoverItem.margins.top
                    bottomMargin: informativeTabBox.textMargin + hoverItem.margins.bottom
                    rightMargin: hoverItem.margins.right
                    leftMargin: 5
                }
            }
            Text {
                id: desktopNameItem
                horizontalAlignment:  Text.AlignHLeft
                text: desktopName
                font.bold: false
                font.italic: true
                color: theme.textColor
                elide: Text.ElideMiddle
                visible: informativeTabBox.allDesktops
                anchors {
                    left: iconItem.right
                    right: parent.right
                    top: captionItem.bottom
                    topMargin: informativeTabBox.textMargin
                    bottom: parent.bottom
                    bottomMargin: informativeTabBox.textMargin + hoverItem.margins.bottom
                    rightMargin: hoverItem.margins.right
                    leftMargin: 5
                }
            }
        }
    }
    

    //list background
    PlasmaCore.FrameSvgItem {
        id: background
        anchors.fill: parent
        imagePath: "dialogs/background"
    }


    //Caption
    Rectangle {
        id: selectedTask
        height: 32
        color: "transparent"
        anchors {
            top: parent.top
            left: parent.left
            right: parent.right
            topMargin: background.margins.top
            leftMargin: background.margins.left
            rightMargin: background.margins.right
            bottomMargin: 10
        }
        
        
        Image {
            id: iconItemCaption
            source: "image://client/" + listView.currentIndex + "/" + informativeTabBox.imagePathPrefix + "-" + listView.imageId + "/selected"
            width: 32
            height: 32
            sourceSize {
                width: 32
                height: 32
            }
            anchors {
                verticalCenter: parent.verticalCenter
                left: parent.left
                leftMargin: hoverItem.margins.left
            }
        }
        Text {
            id: captionItemCaption
            height: 32
            horizontalAlignment: Text.AlignHLeft
            verticalAlignment: Text.AlignVCenter
            text: listView.currentItem ? listView.currentItem.myData.caption : ""
            font.bold: false
            font.pointSize: 18
            color: theme.textColor
            clip: true
            elide: Text.ElideRight
            anchors {
                left: iconItemCaption.right
                right: parent.right
                top: parent.top
                topMargin: informativeTabBox.textMargin
                rightMargin: hoverItem.margins.right
                leftMargin: 15
            }
        }
    }
    
    
    //Thumbnail
    Rectangle {
        id: thumbnail
        width: parent.width / 2
        color: "transparent"
        anchors {
            top: selectedTask.bottom
            bottom: listView.bottom
        }
        Repeater {
            model: clientModel
            delegate:KWin.ThumbnailItem {
                wId: listView.currentItem ? listView.currentItem.myData.windowId : -1
                anchors.centerIn: parent
                width: 200
                height: 200
            }
        }
    }
    
    //List
    ListView {
        id: listView
        objectName: "listView"
        width: parent.width / 2
        height: childrenRect.height
        
        function calculateMaxRowWidth() {
            var width = 0;
            var textElement = Qt.createQmlObject(
                'import Qt 4.7;'
                + 'Text {\n'
                + '     text: "' + itemCaption(informativeTabBox.longestCaption, true) + '"\n'
                + '     font.bold: true\n'
                + '     visible: false\n'
                + '}',
                listView, "calculateMaxRowWidth");
            width = Math.max(textElement.width, width);
            textElement.destroy();
            return width + 32 ;
        }
        /**
        * Calculates the height of one row based on the text height and icon size.
        * @return Row height
        **/
        function calcRowHeight() {
            var textElement = Qt.createQmlObject(
                'import Qt 4.7;'
                + 'Text {\n'
                + '     text: "Some Text"\n'
                + '     font.bold: true\n'
                + '     visible: false\n'
                + '}',
                listView, "calcRowHeight");
            var height = textElement.height;
            textElement.destroy();
            // icon size or two text elements and margins and hoverItem margins
            return Math.max(32, height*2 + informativeTabBox.textMargin * 3 + hoverItem.margins.top + hoverItem.margins.bottom);
        }
        
        signal currentIndexChanged(int index)
        // the maximum text width + icon item width (32 + 4 margin) + margins for hover item + margins for background
        property int maxRowWidth: calculateMaxRowWidth()
        property int rowHeight: calcRowHeight()
        
        // used for image provider URL to trick Qt into reloading icons when the model changes
        property int imageId: 0
        anchors {
            right: parent.right
            top: selectedTask.bottom
            rightMargin: background.margins.right
            bottom: parent.bottom
            bottomMargin: background.margins.bottom
        }
        clip: true
        delegate: listDelegate
        highlight: PlasmaCore.FrameSvgItem {
            id: highlightItem
            imagePath: "widgets/viewitem"
            prefix: "hover"
            width: listView.width
        }
        highlightMoveDuration: 250
        preferredHighlightBegin: 40
        preferredHighlightEnd: 120
        highlightRangeMode: ListView.ApplyRange
        boundsBehavior: Flickable.StopAtBounds
        MouseArea {
            anchors.fill: parent
            hoverEnabled: true
            onPositionChanged: {
                listView.currentIndex = listView.indexAt(mouse.x, mouse.y);
                listView.currentIndexChanged(listView.currentIndex);
            }
            //prevent highlight range from needlessly moving the list when mouse is inside,
            //possibly making user select something they didn't want
            onEntered: {
                listView.highlightRangeMode = ListView.NoHighlightRange
            }
            onExited: {
                listView.highlightRangeMode = ListView.ApplyRange
            }
        }
    }
    
    /*
    * Key navigation on outer item for two reasons:
    * @li we have to emit the change signal
    * @li on multiple invocation it does not work on the list view. Focus seems to be lost.
    **/
    Keys.onPressed: {
        if (event.key == Qt.Key_Up) {
            listView.decrementCurrentIndex();
            listView.currentIndexChanged(listView.currentIndex);
        } else if (event.key == Qt.Key_Down) {
            listView.incrementCurrentIndex();
            listView.currentIndexChanged(listView.currentIndex);
        }
    }
}
