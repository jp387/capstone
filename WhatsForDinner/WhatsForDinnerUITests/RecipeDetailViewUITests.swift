//
//  RecipeDetailViewUITests.swift
//  WhatsForDinnerUITests
//
//  Created by John Phung on 11/29/23.
//

import XCTest

final class RecipeDetailViewUITests: XCTestCase {
  // swiftlint:disable implicitly_unwrapped_optional
  var app: XCUIApplication!
  // swiftlint:enable implicitly_unwrapped_optional

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

  func test_selectedListCellShowsDetailView() {
    let homeCollectionViews = app.collectionViews["recipe-list"]
    XCTAssert(homeCollectionViews.waitForExistence(timeout: 10))
    let homeFirstSelectedListbutton = homeCollectionViews.buttons.element(boundBy: 0)
    homeFirstSelectedListbutton.tap()

    XCTAssert(app.otherElements.staticTexts["recipe-header"].exists)
  }
}
