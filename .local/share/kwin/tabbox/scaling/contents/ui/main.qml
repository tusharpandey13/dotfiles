/********************************************************************
 KWin - the KDE window manager
 This file is part of the KDE project.

 Copyright (C) 2013 Intevation GmbH
 Author: Andre Heinecke <aheinecke@intevation.de>

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
    id: fittingTabBox
    property int screenWidth : 1
    property int screenHeight : 1
    property real screenFactor: screenWidth/screenHeight
    property int imagePathPrefix: (new Date()).getTime()
    property int captionDelegateHeight: 40

    // The maximal width per Window for thumbnails
    property int maxThumbWidth: 300

    // Below this size text is no longer shown
    property int textThreshold: 160

    // Below this size thumbnails are no longer shown
    property int thumbThreshold: 64

    // Optimal is showing the largest mode captionthumb
    property int optimalWidth: (maxThumbWidth + hoverItem.margins.left + hoverItem.margins.right) *
                                thumbnailListView.count + background.margins.left + background.margins.bottom

    // Height varies depending on the thumbsize and the state
    property int optimalHeight: fittingThumbsWidth * (1.0/screenFactor) + hoverItem.margins.top +
                                hoverItem.margins.bottom + background.margins.top + background.margins.bottom +
                                captionDelegateHeight

    // Otherwise we use 90% screen width
    property int maxWidth: screenWidth * 0.9

    // Calculate the best fit minimum is the icon size of 32px + margins
    // we start to scroll below that.
    property int fittingThumbsWidth: Math.max(Math.min(maxWidth / thumbnailListView.count - hoverItem.margins.left +
                                     hoverItem.margins.right - thumbnailListView.spacing - 5,
                                     maxThumbWidth), 32 + hoverItem.margins.right + hoverItem.margins.left )

    property bool canStretchX: false
    property bool canStretchY: false
    width: Math.min(Math.max(screenWidth * 0.3, optimalWidth), maxWidth)
    height: Math.min(Math.max(screenHeight * 0.15, optimalHeight), maxWidth)
    clip: true

    property int maxWindowsThumbnail: Math.floor(maxWidth / (thumbThreshold + hoverItem.margins.left + hoverItem.margins.right))

    states: [
        State {
            name: "CAPTIONTEXT" // Variable size thumbnails with icon and caption below
            when: (fittingThumbsWidth >= textThreshold)
            PropertyChanges {
                target: captionFrame;
                visible: false
            }
            PropertyChanges {
                target: thumbnailListView
                visible: true
            }
        },
        State {
            name: "THUMBICONS" // Thumbnails with icons below
            when: (fittingThumbsWidth >= thumbThreshold && fittingThumbsWidth < textThreshold )
            PropertyChanges {
                target: fittingTabBox
                height: optimalHeight + captionDelegateHeight + hoverItem.margins.bottom
            }
            PropertyChanges {
                target: captionFrame
                visible: true
            }
            PropertyChanges {
                target: thumbnailListView
                visible: true
            }
        },
        State {
            name: "CAPTIONICONS" // Only the Icons with a central caption bar
            when: (fittingThumbsWidth < thumbThreshold)
            PropertyChanges {
                target: fittingTabBox
                height: optimalHeight + captionDelegateHeight
            }
            PropertyChanges {
                target: captionFrame;
                visible: true
            }
        }
    ]

    function setModel(model) {
        thumbnailListView.model = model;
        thumbnailListView.imageId++;
    }

    function modelChanged() {
        thumbnailListView.imageId++;
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

    PlasmaCore.FrameSvgItem {
        id: background
        anchors.fill: parent
        imagePath: "dialogs/background"
    }
    // just to get the margin sizes
    PlasmaCore.FrameSvgItem {
        id: hoverItem
        imagePath: "widgets/viewitem"
        prefix: "hover"
        visible: false
    }

    PlasmaCore.Theme {
        id: theme
    }

    ListView {
        signal currentIndexChanged(int index)
        objectName: "listView"
        id: thumbnailListView
        orientation: ListView.Horizontal
        property int imageId: 0
        spacing: 5
        height: fittingTabBox.fittingThumbsWidth * (1.0/screenFactor) + hoverItem.margins.bottom +
                hoverItem.margins.top + captionDelegateHeight
        highlightMoveDuration: 250
        width: Math.min(parent.width - (anchors.leftMargin + anchors.rightMargin) -
               (hoverItem.margins.left + hoverItem.margins.right), fittingTabBox.fittingThumbsWidth * count + 5 * (count - 1))
        anchors {
            top: parent.top
            topMargin: background.margins.top
            leftMargin: background.margins.left
            rightMargin: background.margins.right
            horizontalCenter: parent.horizontalCenter
        }
        clip: true
        delegate: Item {
            property alias data: thumbnailItem.data
            id: delegateItem
            width: fittingTabBox.fittingThumbsWidth
            height: fittingTabBox.fittingThumbsWidth*(1.0/screenFactor) + captionDelegateHeight

            Item {
                id: thumbnailContainer
                width: fittingTabBox.fittingThumbsWidth
                height: fittingTabBox.fittingThumbsWidth*(1.0/screenFactor)

                KWin.ThumbnailItem {
                    property variant data: model
                    id: thumbnailItem
                    wId: windowId
                    anchors {
                        fill: parent
                        leftMargin: hoverItem.margins.left
                        rightMargin: hoverItem.margins.right
                        topMargin: hoverItem.margins.top
                        bottomMargin: hoverItem.margins.bottom
                    }
                }
                states: [
                    State {
                        name: "HIDDENTHUMB" // Thumbnails with icons below
                        when: (fittingTabBox.fittingThumbsWidth < fittingTabBox.thumbThreshold)
                        PropertyChanges {
                            target: thumbnailItem
                            visible: false
                        }
                        AnchorChanges {
                            // Move the icon up
                            target: captionDelegate
                            anchors.top: parent.top
                            anchors.bottom: undefined
                        }
                    },
                    State {
                        name: "SHOWNTHUMB" // Thumbnails with icons below
                        when: (fittingTabBox.fittingThumbsWidth >= fittingTabBox.thumbThreshold)
                        PropertyChanges {
                            target: thumbnailItem
                            visible: true
                        }
                        AnchorChanges {
                            // Move the icon down again
                            target: captionDelegate
                            anchors.bottom: parent.bottom
                        }
                    }
                ]
            }
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    thumbnailListView.currentIndex = index;
                    thumbnailListView.currentIndexChanged(thumbnailListView.currentIndex);
                }
            }
            Item {
                id: captionDelegate
                height: captionDelegateHeight
                width: fittingTabBox.fittingThumbsWidth
                states: [
                    State {
                        name: "WITHOUT_TEXT" // Thumbnails with icons below
                        when: (fittingTabBox.fittingThumbsWidth < fittingTabBox.textThreshold)
                        PropertyChanges { target: textItem; visible: false }
                        AnchorChanges {
                            target: iconItem;
                            anchors.right: undefined;
                            anchors.horizontalCenter: parent.horizontalCenter;
                        }
                    },
                    State {
                        name: "WITHTEXT" // Variable size thumbnails with icon and caption below
                        when: (fittingTabBox.fittingThumbsWidth >= fittingTabBox.textThreshold)
                        PropertyChanges {
                            target: textItem;
                            visible: true;
                            width: parent.width - iconItem.width * 2 - hoverItem.margins.left * 2 - hoverItem.margins.right * 2
                        }
                        AnchorChanges {
                            target: iconItem;
                            anchors.right: textItem.left;
                            anchors.horizontalCenter: undefined;
                        }
                    }
                ]
                Image {
                    id: iconItem
                    source: "image://client/" + index + "/" + fittingTabBox.imagePathPrefix + "-" +
                            thumbnailListView.imageId + "/selected"
                    width: 32
                    height: 32
                    sourceSize {
                        width: 32
                        height: 32
                    }
                    anchors {
                        right: textItem.left
                        leftMargin: hoverItem.margins.left
                        rightMargin: hoverItem.margins.right
                        topMargin: hoverItem.margins.top
                        bottomMargin: hoverItem.margins.bottom
                    }
                }
                Text {
                    id: textItem
                    text: itemCaption(caption, minimized)
                    property int maxWidth: parent.width - iconItem.width * 2 - hoverItem.margins.left * 2 - hoverItem.margins.right * 2

                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    color: theme.textColor
                    elide: Text.ElideMiddle
                    font {
                        bold: true
                    }
                    anchors {
                        verticalCenter: parent.verticalCenter
                        horizontalCenter: parent.horizontalCenter
                    }
                    Component.onCompleted: {
                        width = Math.min(paintedWidth, maxWidth)
                    }
                }
                anchors {
                    horizontalCenter: parent.horizontalCenter
                    bottom: parent.bottom
                    leftMargin: hoverItem.margins.left
                    rightMargin: hoverItem.margins.right
                    topMargin: hoverItem.margins.top
                    bottomMargin: hoverItem.margins.bottom / 2
                }
            }
        }
        highlight: PlasmaCore.FrameSvgItem {
            id: highlightItem
            imagePath: "widgets/viewitem"
            prefix: "hover"
            width: fittingTabBox.fittingThumbsWidth
            height: fittingTabBox.fittingThumbsWidth*(1.0/screenFactor) + captionDelegateHeight
        }
        boundsBehavior: Flickable.StopAtBounds
    }
    Item {
        height: 40
        id: captionFrame
        visible:false
        anchors {
            top: thumbnailListView.bottom
            left: parent.left
            right: parent.right
            leftMargin: background.margins.left
            rightMargin: background.margins.right
            bottomMargin: background.margins.bottom
        }
        Text {
            function constrainWidth() {
                if (textItem.width > textItem.maxWidth && textItem.width > 0 && textItem.maxWidth > 0) {
                    textItem.width = textItem.maxWidth;
                } else {
                    textItem.width = undefined;
                }
            }
            function calculateMaxWidth() {
                textItem.maxWidth = fittingTabBox.width - captionFrame.anchors.leftMargin -
                captionFrame.anchors.rightMargin - captionFrame.anchors.rightMargin;
            }
            id: textItem
            property int maxWidth: 0
            text: thumbnailListView.currentItem ? thumbnailListView.currentItem.data.caption : ""
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            color: theme.textColor
            elide: Text.ElideMiddle
            font {
                bold: true
            }
            anchors {
                verticalCenter: parent.verticalCenter
                horizontalCenter: parent.horizontalCenter
            }
            onTextChanged: textItem.constrainWidth()
            Component.onCompleted: textItem.calculateMaxWidth()
            Connections {
                target: fittingTabBox
                onWidthChanged: {
                    textItem.calculateMaxWidth();
                    textItem.constrainWidth();
                }
            }
        }
    }
}
