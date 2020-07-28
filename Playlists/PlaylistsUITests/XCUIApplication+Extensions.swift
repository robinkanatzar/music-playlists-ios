//
//  XCUIApplication+Extensions.swift
//  PlaylistsUITests
//
//  Created by Robin Kanatzar on 7/28/20.
//  Copyright © 2020 Robin Kanatzar. All rights reserved.
//

import XCTest

extension XCUIApplication {
    var isDisplayingPlaylistList: Bool {
        return otherElements["playlistListView"].waitForExistence(timeout: 5000)
    }
    
    var isDisplayingPlaylistDetail: Bool {
        return otherElements["playlistDetailView"].exists
    }
}
