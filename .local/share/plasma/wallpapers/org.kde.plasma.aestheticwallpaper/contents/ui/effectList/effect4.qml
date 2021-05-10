/*
    SPDX-FileCopyrightText: 2020 AERegeneratel38 <mukunda.adhikari@outlook.com>
    SPDX-License-Identifier: LGPL-2.1-or-later
*/

import QtQuick 2.1

import QtQuick.Layouts 1.1
import QtGraphicalEffects 1.12

import org.kde.plasma.core 2.0
import org.kde.plasma.components 2.0 as PlasmaComponents
import org.kde.plasma.extras 2.0 as PlasmaExtras
import org.kde.plasma.wallpapers.image 2.0 as Wallpaper

Item {
    id: root

     width: 1920
     height: 1080
    
      function setUrl(url) {
        wallpaper.configuration.Image = url
        imageWallpaper.addUsersWallpaper(url);
    }
    
    
    Image {
        id: bug2
        source: wallpaper.configuration.Image
        sourceSize: Qt.size(1920, 1080)
        fillMode: Image.PreserveAspectCrop
        smooth: true
        z:-1
        
        
    }
    
    
    
    BrightnessContrast {
        id: hello
         anchors.fill: bug2
            source: bug2
            brightness: -0.75
            
        
    }
    
  Image {
        id: bug
        source: wallpaper.configuration.Image
        sourceSize: Qt.size(1920, 1080)
        fillMode: Image.PreserveAspectCrop
        smooth: true
        layer.enabled: true
        layer.effect: OpacityMask {
            maskSource: mask
        }
        
    }

    Image {
        id: mask
        source: wallpaper.configuration.SelectedLogo
        sourceSize: Qt.size(parent.width, parent.height)
        smooth: true
        visible: false
    }

    
    
}
