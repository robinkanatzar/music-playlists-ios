//
//  PlaylistsUITests.swift
//  PlaylistsUITests
//
//  Created by Robin Kanatzar on 7/28/20.
//  Copyright © 2020 Robin Kanatzar. All rights reserved.
//

import XCTest

class PlaylistsUITests: XCTestCase {
    var app: XCUIApplication!
    
    override func setUp() {
        super.setUp()
        
        continueAfterFailure = false
        app = XCUIApplication()
        app.launchArguments.append("--uitesting")
    }
    
    func testShowPlayistDetail() {
        app.launch()
                
        var firstChildTitle: String?
        
        // On Playlist List view, click on the first item in the collection view
        let firstChild = app.collectionViews.children(matching: .any).element(boundBy: 0)
        if firstChild.waitForExistence(timeout: 5000) {
            firstChildTitle = firstChild.accessibilityLabel
            firstChild.tap()
        }
        
        // Confirm showing Playlist Detail View
        XCTAssertTrue(app.isDisplayingPlaylistDetail, "Playlist detail view not displayed")
        
        // Confirm the title on the detail page is the same as the item title
        if let firstChildTitle = firstChildTitle {
            XCTAssertTrue(app.staticTexts[firstChildTitle].exists)
        }
    }
    
}
