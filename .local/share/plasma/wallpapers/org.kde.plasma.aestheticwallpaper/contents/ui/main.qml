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
import "./effectList"


Item {
    id: root
    readonly property string configuredImage: wallpaper.configuration.Image

    
    function setUrl(url) {
        wallpaper.configuration.Image = url
        imageWallpaper.addUsersWallpaper(url);
    }
    
    Loader {
        id: toyLoader
        source: wallpaper.configuration.SelectedEffect
        anchors.fill: parent
    }
}
