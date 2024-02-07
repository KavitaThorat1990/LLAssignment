//
//  HomeUITests.swift
//  LloydsAssignmentNewsAppUITests
//
//  Created by Kavita Thorat on 05/02/24.
//

import XCTest
@testable import LloydsAssignmentNewsApp

final class NewsUITests: XCTestCase {
    
    let app = XCUIApplication()
    
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        app.launchArguments.append("UITesting")
        app.launch()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testHomeScreenLoadWithMockData() {
        let newsTable = app.tables[Constants.AccessibilityIds.newsListTable]
        XCTAssertTrue(newsTable.waitForExistence(timeout: 5.0), "News table not found")

        let firstCell = newsTable.cells.element(boundBy: 0)
        XCTAssertTrue(firstCell.exists, "First news cell not found")
    }
}
