//
//  RecipeSearchViewUITests.swift
//  WhatsForDinnerUITests
//
//  Created by John Phung on 11/29/23.
//

import XCTest

final class RecipeSearchViewUITests: XCTestCase {
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

  func test_selectedSearchTab() {
    let tabBar = app.tabBars["Tab Bar"]
    let searchButton = tabBar.buttons["Search"]
    searchButton.tap()
    XCTAssert(app.navigationBars["Find Your Dinner"].exists)
  }

  func test_recipeSearchSuccess() {
    let tabBar = app.tabBars["Tab Bar"]
    let searchButton = tabBar.buttons["Search"]
    searchButton.tap()

    let searchNavigationBar = app.navigationBars["Find Your Dinner"]
    let searchTextField = searchNavigationBar.searchFields["Search your dinner here..."]
    searchTextField.tap()
    XCTAssert(searchTextField.waitForExistence(timeout: 10))
    searchTextField.typeText("Salsa")
    app.keyboards.buttons["search"].tap()

    let recipeList = app.descendants(matching: .any)
      .matching(identifier: "search-list")
      .element

    XCTAssert(recipeList.waitForExistence(timeout: 20))

    let rows = recipeList.cells
    XCTAssertEqual(rows.count, 0)
  }

  func test_recipeSearchFailure() {
    let tabBar = app.tabBars["Tab Bar"]
    let searchButton = tabBar.buttons["Search"]
    searchButton.tap()

    let searchNavigationBar = app.navigationBars["Find Your Dinner"]
    let searchTextField = searchNavigationBar.searchFields["Search your dinner here..."]
    searchTextField.tap()
    XCTAssert(searchTextField.waitForExistence(timeout: 10))
    searchTextField.typeText("John")
    app.keyboards.buttons["search"].tap()
    XCTAssert(app.staticTexts["No Results"].waitForExistence(timeout: 10))
  }
}
