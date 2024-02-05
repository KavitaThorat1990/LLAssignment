//
//  NewsDetailsUITests.swift
//  LloydsAssignmentNewsAppUITests
//
//  Created by Kavita Thorat on 05/02/24.
//

import XCTest
@testable import LloydsAssignmentNewsApp

final class NewsDetailsUITests: XCTestCase {

    let app = XCUIApplication()

    override func setUp() {
        super.setUp()
        continueAfterFailure = false

        // Set the launch argument to indicate UI testing
        app.launchArguments.append("UITesting")

        // Launch the app
        app.launch()
    }

    func testNewsDetailScreen() {
        let newsTable = app.tables[Constants.AccessibilityIds.newsListTable]
        XCTAssertTrue(newsTable.waitForExistence(timeout: 5.0), "News table not found")

        // Tap on the first cell in the second section (replace with actual index)
        let cell = newsTable.cells.element(boundBy: 1)
        XCTAssertTrue(cell.exists, "News cell not found")
        cell.tap()

        let label = app.staticTexts["title"]
        XCTAssertTrue(label.value != nil)
        XCTAssertNotNil(app.buttons[Constants.AccessibilityIds.seeMoreButton].firstMatch)

        // Navigate back to the home screen
        app.navigationBars.buttons["Home"].tap()
        print(app.navigationBars.buttons)

        // Validate that you are back on the home screen
        XCTAssertTrue(newsTable.waitForExistence(timeout: 5.0), "Not back on the home screen")
    }
}
