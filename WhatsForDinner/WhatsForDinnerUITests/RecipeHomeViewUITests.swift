//
//  WhatsForDinnerUITests.swift
//  WhatsForDinnerUITests
//
//  Created by John Phung on 11/12/23.
//

import XCTest

final class RecipeHomeViewUITests: XCTestCase {
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

  func test_recipeHomeViewAppears() {
    let recipeList = app.descendants(matching: .any)
      .matching(identifier: "recipe-list")
      .element

    XCTAssert(recipeList.waitForExistence(timeout: 20))
    XCTAssert(app.navigationBars["Dinner Recipes"].exists)
  }

  func test_listCellRefreshButtonLoadsNewRecipes() {
    let homeNavigationBars = app.navigationBars["Dinner Recipes"]
    let homeRefreshButton = homeNavigationBars.buttons["refresh-button"]
    homeRefreshButton.tap()

    let recipeList = app.descendants(matching: .any)
      .matching(identifier: "recipe-list")
      .element

    XCTAssert(recipeList.waitForExistence(timeout: 20))

    recipeList.swipeUp()
    recipeList.swipeUp()
    recipeList.swipeUp()
    recipeList.swipeUp()

    let rows = recipeList.cells
    XCTAssertEqual(rows.count, 7)
  }
}
