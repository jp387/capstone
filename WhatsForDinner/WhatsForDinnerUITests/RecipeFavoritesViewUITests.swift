//
//  RecipeFavoritesViewUITests.swift
//  WhatsForDinnerUITests
//
//  Created by John Phung on 11/29/23.
//

import XCTest

final class RecipeFavoritesViewUITests: XCTestCase {
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

  func test_selectedFavoritesTab() {
    let tabBar = app.tabBars["Tab Bar"]
    let favoritesButton = tabBar.buttons["Favorites"]
    favoritesButton.tap()
    XCTAssert(app.navigationBars["Favorited Recipes"].exists)
  }

  func test_noFavoritesSearchResults() {
    let tabBar = app.tabBars["Tab Bar"]
    let favoritesButton = tabBar.buttons["Favorites"]
    favoritesButton.tap()

    let favoritessNavigationBar = app.navigationBars["Favorited Recipes"]
    let favoritesSearchTextField = favoritessNavigationBar.searchFields["Search for your favorited recipes"]
    favoritesSearchTextField.tap()

    XCTAssert(favoritesSearchTextField.waitForExistence(timeout: 10))

    favoritesSearchTextField.typeText("John")
    XCTAssert(app.staticTexts["No Results"].exists)
  }
}
