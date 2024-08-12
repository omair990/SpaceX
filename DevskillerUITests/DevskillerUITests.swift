//
//  DevskillerUITests.swift
//  DevskillerUITests
//
//  Created by Ivo Silva on 18/09/2020.
//  Copyright © 2020 Mindera. All rights reserved.
//

import XCTest

class DevskillerUITests: XCTestCase {

    var app: XCUIApplication!

    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }

    override func tearDown() {
        app = nil
        super.tearDown()
    }

    func testLaunchListDisplays() {
        // Given: The app is launched and the launch list screen is displayed

        // When: Data is being fetched and displayed in the table view

        let expectation = self.expectation(description: "Wait for table view to load data")

        // Check the number of cells after a delay, giving time for data to load
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            let tableView = self.app.tables["LaunchTableView"]
            let cellCount = tableView.cells.count

            // Then: The table view should have more than 0 cells
            XCTAssertGreaterThan(cellCount, 0, "The launch list table view should have cells.")
            expectation.fulfill()
        }

        waitForExpectations(timeout: 5, handler: nil)
    }

    func testLaunchDetailDisplays() {
        // Tap on the first launch and check if the detail view appears
        let tableView = app.tables["LaunchTableViewCell"]
        let firstCell = tableView.cells.element(boundBy: 0)
        if firstCell.exists {
            firstCell.tap()
            XCTAssertTrue(app.staticTexts["LaunchTableViewCell"].exists, "Launch detail title label exists.")
        }
    }
}
