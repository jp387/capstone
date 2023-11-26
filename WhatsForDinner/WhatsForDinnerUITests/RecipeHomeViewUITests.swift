//
//  WhatsForDinnerUITests.swift
//  WhatsForDinnerUITests
//
//  Created by John Phung on 11/12/23.
//

import XCTest
@testable import WhatsForDinner

final class RecipeHomeViewUITests: XCTestCase {
  // swiftlint:disable implicitly_unwrapped_optional
  var app: XCUIApplication!
  // swiftlint:enable implicitly_unwrapped_optional

  override func setUpWithError() throws {
    continueAfterFailure = false
    app = XCUIApplication()
    app.launch()
    try super.setUpWithError()
  }

  override func tearDownWithError() throws {
    app = nil
    try super.tearDownWithError()
  }

  func test_listCellLoadsCorrectly() {
    let recipeList = app.descendants(matching: .any)
      .matching(identifier: "recipe-list")
      .element

    XCTAssert(recipeList.waitForExistence(timeout: 20))

    let rows = recipeList.cells
    XCTAssertEqual(rows.count, 7)
  }

  func test_selectedListCellShowsDetailView() {
    let recipeList = app.descendants(matching: .any)
      .matching(identifier: "recipe-list")
      .element

    XCTAssert(recipeList.waitForExistence(timeout: 20))

    let rows = recipeList.cells
    XCTAssertEqual(rows.count, 7)
  }
}
