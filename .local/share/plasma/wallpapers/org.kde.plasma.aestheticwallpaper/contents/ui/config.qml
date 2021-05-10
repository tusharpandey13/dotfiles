/*
    SPDX-FileCopyrightText: 2020 AERegeneratel38 <mukunda.adhikari@outlook.com>
    SPDX-License-Identifier: LGPL-2.1-or-later
*/

import QtQuick 2.12
import QtQuick.Layouts 1
import QtQuick.Controls 2.12
import QtQuick.Window 2.0 // for Screen
import org.kde.plasma.core 2.0 as Plasmacore
import org.kde.plasma.wallpapers.image 2.0 as Wallpaper
import org.kde.kquickcontrols 2.0 as KQuickControls
import org.kde.kquickcontrolsaddons 2.0
import org.kde.kconfig 1.0 // for KAuthorized
import org.kde.draganddrop 2.0 as DragDrop
import org.kde.kcm 1.1 as KCM
import org.kde.kirigami 2.5 as Kirigami


ColumnLayout {
    id: root
     property alias cfg_SelectedEffect: selectedEffectField.text
     property alias cfg_SelectedLogo: selectedLogoField.text
     property string cfg_Image
      property alias cfg_Slideshow: slideshowCheckBox.checked
     
     SystemPalette {
        id: syspal
    }

    Wallpaper.Image {
        id: imageWallpaper
        targetSize: {
            if (typeof plasmoid !== "undefined") {
                return Qt.size(plasmoid.width, plasmoid.height)
            }
            // Lock screen configuration case
            return Qt.size(Screen.width, Screen.height)
        }
       
    }
    

    RowLayout {
        spacing: units.largeSpacing / 2

        // To allow aligned integration in the settings form,
        // "formAlignment" is a property injected by the config containment
        // which defines the offset of the value fields
        Label {
            Layout.minimumWidth: width
            Layout.maximumWidth: width
            width: formAlignment - units.largeSpacing
            horizontalAlignment: Text.AlignRight

            // use i18nd in config QML, as the default textdomain is set to that of the config container
            text: "Choose Effect"
        }
          ComboBox {
              id: selectedEffect
              model: ListModel{
                  ListElement { name: "CenteredColor"; path: "./effectList/effect1.qml"}
                  ListElement { name: "CenteredVisible"; path: "./effectList/effect2.qml"}
                  ListElement { name: "CenteredGlow"; path: "./effectList/effect3.qml"}
                  ListElement { name: "CenteredHighlight"; path: "./effectList/effect4.qml"}
                  }
                  textRole: "name"
                  onCurrentTextChanged: {
                  selectedEffectField.text = model.get(currentIndex).path
                  
                  // console.debug(JSON.stringify(main.Loader))
                  // main.toyLoader.source = model.get(currentIndex).path
              }
                 
              }

   
}
RowLayout {
          spacing: units.largeSpacing / 2

          Label {
              Layout.minimumWidth: width
              Layout.maximumWidth: width
              width: formAlignment - units.largeSpacing
              horizontalAlignment: Text.AlignRight
              text: "Load Effect from Path:"
          }
          TextField {
            id: selectedEffectField
            Layout.minimumWidth: width
            Layout.maximumWidth: width
            width: 435
            text:"./effectList/effect1.qml"
          }
      }
      
    RowLayout {
        spacing: units.largeSpacing / 2

        // To allow aligned integration in the settings form,
        // "formAlignment" is a property injected by the config containment
        // which defines the offset of the value fields
        Label {
            Layout.minimumWidth: width
            Layout.maximumWidth: width
            width: formAlignment - units.largeSpacing
            horizontalAlignment: Text.AlignRight

            // use i18nd in config QML, as the default textdomain is set to that of the config container
            text: "Choose Logo"
        }
          ComboBox {
              id: selectedLogo
              model: ListModel{
                  ListElement { name: "KDE"; path: "../masks/kde.png"}
                  ListElement { name: "Manjaro"; path: "../masks/manjaro.svg"}
                  }
                  textRole: "name"
                  onCurrentTextChanged: {
                  selectedLogoField.text = model.get(currentIndex).path
                  
                  // console.debug(JSON.stringify(main.Loader))
                  // main.toyLoader.source = model.get(currentIndex).path
              }
                 
              }

   
}
RowLayout {
          spacing: units.largeSpacing / 2

          Label {
              Layout.minimumWidth: width
              Layout.maximumWidth: width
              width: formAlignment - units.largeSpacing
              horizontalAlignment: Text.AlignRight
              text: "Load logo from Path:"
          }
          TextField {
            id: selectedLogoField
            Layout.minimumWidth: width
            Layout.maximumWidth: width
            width: 435
            
          }
      }


    default property alias contentData: content.data
    ColumnLayout {
        id: content
    }

    Row {
        id: slideshowRow
        spacing: units.largeSpacing / 2
        Label {
            width: formAlignment - units.largeSpacing
            anchors.verticalCenter: slideshowCheckBox.verticalCenter
            horizontalAlignment: Text.AlignRight
            text: i18n("Slideshow:")
            visible: false
        }
        CheckBox {
            id: slideshowCheckBox
            visible: false
            
        }
    }

    Component {
        id: foldersComponent
        ColumnLayout {
            anchors.fill: parent
            Connections {
                target: root
                onHoursIntervalValueChanged: hoursInterval.value = root.hoursIntervalValue
                onMinutesIntervalValueChanged: minutesInterval.value = root.minutesIntervalValue
                onSecondsIntervalValueChanged: secondsInterval.value = root.secondsIntervalValue
            }
            //FIXME: there should be only one spinbox: QtControls spinboxes are still too limited for it tough
            RowLayout {
                Layout.fillWidth: true
                spacing: units.largeSpacing / 2
                Label {
                    Layout.minimumWidth: formAlignment - units.largeSpacing
                    horizontalAlignment: Text.AlignRight
                    text: i18nd("plasma_wallpaper_org.kde.image","Change every:")
                }
                SpinBox {
                    id: hoursInterval
                    Layout.minimumWidth: textMetrics.width + units.gridUnit
                    width: units.gridUnit * 3
                    value: root.hoursIntervalValue
                    from: 0
                    to: 24
                    editable: true
                    onValueChanged: cfg_SlideInterval = hoursInterval.value * 3600 + minutesInterval.value * 60 + secondsInterval.value
                }
                Label {
                    text: i18nd("plasma_wallpaper_org.kde.image","Hours")
                }
                Item {
                    Layout.preferredWidth: units.gridUnit
                }
                SpinBox {
                    id: minutesInterval
                    Layout.minimumWidth: textMetrics.width + units.gridUnit
                    width: units.gridUnit * 3
                    value: root.minutesIntervalValue
                    from: 0
                    to: 60
                    editable: true
                    onValueChanged: cfg_SlideInterval = hoursInterval.value * 3600 + minutesInterval.value * 60 + secondsInterval.value
                }
                Label {
                    text: i18nd("plasma_wallpaper_org.kde.image","Minutes")
                }
                Item {
                    Layout.preferredWidth: units.gridUnit
                }
                SpinBox {
                    id: secondsInterval
                    Layout.minimumWidth: textMetrics.width + units.gridUnit
                    width: units.gridUnit * 3
                    value: root.secondsIntervalValue
                    from: root.hoursIntervalValue === 0 && root.minutesIntervalValue === 0 ? 1 : 0
                    to: 60
                    editable: true
                    onValueChanged: cfg_SlideInterval = hoursInterval.value * 3600 + minutesInterval.value * 60 + secondsInterval.value
                }
                Label {
                    text: i18nd("plasma_wallpaper_org.kde.image","Seconds")
                }
            }
            ScrollView {
                id: foldersScroll
                Layout.fillHeight: true;
                Layout.fillWidth: true
                Component.onCompleted: foldersScroll.background.visible = true;
                ListView {
                    id: slidePathsView
                    anchors.margins: 4
                    model: imageWallpaper.slidePaths
                    delegate: Label {
                        text: modelData
                        width: slidePathsView.width
                        height: Math.max(paintedHeight, removeButton.height);
                        ToolButton {
                            id: removeButton
                            anchors {
                                verticalCenter: parent.verticalCenter
                                right: parent.right
                            }
                            icon.name: "list-remove"
                            onClicked: imageWallpaper.removeSlidePath(modelData);
                        }
                    }
                }
            }
        }
    }

    Component {
        id: thumbnailsComponent
        KCM.GridView {
            id: wallpapersGrid
            anchors.fill: parent

            //that min is needed as the module will be populated in an async way
            //and only on demand so we can't ensure it already exists
            view.currentIndex: Math.min(imageWallpaper.wallpaperModel.indexOf(cfg_Image), imageWallpaper.wallpaperModel.count-1)
            //kill the space for label under thumbnails
            view.model: imageWallpaper.wallpaperModel
            view.delegate: WallpaperDelegate {
                
            }
        }
    }

    Loader {
        Layout.fillWidth: true
        Layout.fillHeight: true
        sourceComponent: cfg_Slideshow ? foldersComponent : thumbnailsComponent
    }

    RowLayout {
        id: buttonsRow
        Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
        Button {
            visible: cfg_Slideshow
            icon.name: "list-add"
            text: i18nd("plasma_wallpaper_org.kde.image","Add Folder...")
            onClicked: imageWallpaper.showAddSlidePathsDialog()
        }
        Button {
            visible: !cfg_Slideshow
            icon.name: "list-add"
            text: i18nd("plasma_wallpaper_org.kde.image","Add Image...")
            onClicked: imageWallpaper.showFileDialog();
        }
        Button {
            icon.name: "get-hot-new-stuff"
            text: i18nd("plasma_wallpaper_org.kde.image","Get New Wallpapers...")
            visible: KAuthorized.authorize("ghns")
            onClicked: imageWallpaper.getNewWallpaper(this);
        }
    }
      

      
      
      
      
       Item { // tighten layout
        Layout.fillHeight: true
    }
}
