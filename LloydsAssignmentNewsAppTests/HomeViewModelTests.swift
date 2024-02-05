//
//  HomeViewModelTests.swift
//  ExpressNewsTests
//
//  Created by Kavita Thorat on 03/02/24.
//

import XCTest
@testable import LloydsAssignmentNewsApp

final class HomeViewModelTests: XCTestCase {
    
    var viewModel: HomeViewModel!
   
    override func setUp() {
        super.setUp()
       viewModel = HomeViewModel(homeNewsUseCase: UseCaseFactory.createHomeNewsUseCase(isMock: true))
   }

   override func tearDown() {
       super.tearDown()
       viewModel = nil
   }

   func testFetchTrendingNewsForCategories() {
       let expectation = XCTestExpectation(description: "Fetch trending news for categories succeeds")

       viewModel.fetchTrendingNewsForCategories()
           .done {[weak self] categorisedNews in
               XCTAssertFalse(categorisedNews.isEmpty, "Categorised news should not be empty")
               XCTAssertEqual(categorisedNews.count, 3)
               
               var numberOfRows = self?.viewModel.numberOfRowsForSection(section: 1)
               XCTAssertEqual(numberOfRows, 39)
               
               numberOfRows = self?.viewModel.numberOfRowsForSection(section: 0)
               XCTAssertEqual(numberOfRows, 0)
               
               numberOfRows = self?.viewModel.numberOfRowsForSection(section: 4)
               XCTAssertEqual(numberOfRows, 0)
               
               
               expectation.fulfill()
           }
           .catch { error in
               XCTFail("Fetching trending news should not fail: \(error)")
               expectation.fulfill()
           }

       wait(for: [expectation], timeout: 5.0)
   }

   func testFetchFeaturedNews() {
       let expectation = XCTestExpectation(description: "Fetch featured news succeeds")

       viewModel.fetchFeaturedNews(parameters: nil)
           .done {
               XCTAssertFalse(self.viewModel.getFeaturedNews().isEmpty, "Featured news should not be empty")
               expectation.fulfill()
           }
           .catch { error in
               XCTFail("Fetching featured news should not fail: \(error)")
               expectation.fulfill()
           }

       wait(for: [expectation], timeout: 5.0)
   }
    
    func testGetHeaderTitle() {
        let title = viewModel.getHeaderTitle(for: 1)
        XCTAssertEqual(title, Constants.defaultCategories[0])
    }
    
    func testHeightForHeaderInSection() {
        // Test when section is not 0
        XCTAssertEqual(viewModel.heightForHeaderInSection(1), Constants.CellHeights.categoryHeader)

        // Test when section is 0
        XCTAssertEqual(viewModel.heightForHeaderInSection(0), 0.0)
    }
}
