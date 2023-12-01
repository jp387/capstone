//
//  WhatsForDinnerUITests.swift
//  WhatsForDinnerUITests
//
//  Created by John Phung on 11/12/23.
//

import XCTest

final class WhatsForDinnerUITests: XCTestCase {
  // swiftlint:disable implicitly_unwrapped_optional
  var app: XCUIApplication!
  // swiftlint:enable implicitly_unwrapped_optional
  let springboard = XCUIApplication(bundleIdentifier: "com.apple.springboard")

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

  func deleteApplication() {
    XCUIApplication().terminate()

    let icon = springboard.icons["Dinner Ideas"]
    if icon.exists {
      let iconFrame = icon.frame
      let springboardFrame = springboard.frame
      icon.press(forDuration: 5)

      springboard.coordinate(
        withNormalizedOffset:
          CGVector(
            dx: (iconFrame.minX + 3) / springboardFrame.maxX,
            dy: (iconFrame.minY + 3) / springboardFrame.maxY))
      .tap()

      springboard.alerts.buttons["Delete App"].tap()
      springboard.alerts.buttons["Delete"].tap()
    }
  }

  func test_homeViewAppearsAfterOnboardingFinishes() {
    deleteApplication()
    app.launch()

    let onboardingCollectionViews = app.collectionViews["onboarding-view"]
    XCTAssert(onboardingCollectionViews.waitForExistence(timeout: 20))
    let onboardingElements = onboardingCollectionViews
      .cells
      .children(matching: .other)
      .element.children(matching: .other)
      .element
    onboardingElements.swipeLeft()
    onboardingElements.swipeLeft()
    onboardingElements.swipeLeft()
    onboardingElements.buttons["onboarding-button"].tap()

    let recipeList = app.descendants(matching: .any)
      .matching(identifier: "recipe-list")
      .element

    XCTAssert(recipeList.waitForExistence(timeout: 20))

    recipeList.swipeUp()
    recipeList.swipeDown()

    XCTAssert(recipeList.exists)
  }

  func test_recipeHomeViewAppears() {
    let recipeList = app.descendants(matching: .any)
      .matching(identifier: "recipe-list")
      .element

    XCTAssert(recipeList.waitForExistence(timeout: 20))

    recipeList.swipeUp()
    recipeList.swipeDown()

    XCTAssert(recipeList.exists)
  }

  func test_listCellRefreshButtonLoadsNewRecipes() {
    let homeNavigationBars = app.navigationBars["Dinner Recipes"]
    let homeRefreshButton = homeNavigationBars.buttons["refresh-button"]
    XCTAssert(homeRefreshButton.waitForExistence(timeout: 20))
    homeRefreshButton.tap()

    let recipeList = app.descendants(matching: .any)
      .matching(identifier: "recipe-list")
      .element

    XCTAssert(recipeList.waitForExistence(timeout: 20))

    recipeList.swipeUp()
    recipeList.swipeDown()

    XCTAssert(recipeList.exists)
  }

  func test_selectedListCellShowsDetailView() {
    let homeCollectionViews = app.collectionViews["recipe-list"]
    let homeFirstSelectedListbutton = homeCollectionViews.buttons.element(boundBy: 0)
    XCTAssert(homeCollectionViews.waitForExistence(timeout: 20))
    homeFirstSelectedListbutton.tap()

    XCTAssert(app.otherElements.staticTexts["recipe-header"].exists)
  }

  func test_selectedFavoritesTab() {
    let tabBar = app.tabBars["Tab Bar"]
    let favoritesButton = tabBar.buttons["Favorites"]
    XCTAssert(favoritesButton.waitForExistence(timeout: 20))
    favoritesButton.tap()
    XCTAssert(app.navigationBars["Favorited Recipes"].exists)
  }

  func test_noFavoritesSearchResults() {
    let tabBar = app.tabBars["Tab Bar"]
    let favoritesButton = tabBar.buttons["Favorites"]
    XCTAssert(favoritesButton.waitForExistence(timeout: 20))
    favoritesButton.tap()

    let favoritessNavigationBar = app.navigationBars["Favorited Recipes"]
    let favoritesSearchTextField = favoritessNavigationBar.searchFields["Search for your favorited recipes"]
    favoritesSearchTextField.tap()

    XCTAssert(favoritesSearchTextField.waitForExistence(timeout: 10))

    favoritesSearchTextField.typeText("John")
    XCTAssert(app.staticTexts["No Results"].exists)
  }

  func test_selectedSearchTab() {
    let tabBar = app.tabBars["Tab Bar"]
    let searchButton = tabBar.buttons["Search"]
    XCTAssert(searchButton.waitForExistence(timeout: 20))
    searchButton.tap()
    XCTAssert(app.navigationBars["Find Your Dinner"].exists)
  }

  func test_recipeSearchSuccess() {
    let tabBar = app.tabBars["Tab Bar"]
    let searchButton = tabBar.buttons["Search"]
    XCTAssert(searchButton.waitForExistence(timeout: 20))
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
    XCTAssert(searchButton.waitForExistence(timeout: 20))
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
