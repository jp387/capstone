//
//  OnboardingViewUITests.swift
//  WhatsForDinnerUITests
//
//  Created by John Phung on 11/28/23.
//

import XCTest

final class OnboardingViewUITests: XCTestCase {
  // The SwiftLint rule is disabled since the variable will be initialized in the setUp() method
  // swiftlint:disable implicitly_unwrapped_optional
  var app: XCUIApplication!
  // swiftlint:enable implicitly_unwrapped_optional
  let springboard = XCUIApplication(bundleIdentifier: "com.apple.springboard")

  override func setUp() {
    super.setUp()
    continueAfterFailure = false
    deleteApplication()
    app = XCUIApplication()
    app.launchArguments.append("--uitesting")
  }

  override func tearDown() {
    app = nil
    super.tearDown()
  }

  func deleteApplication() {
    XCUIApplication().terminate()

    let icon = springboard.icons["WhatsForDinner"]
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

  func test_onboardingDisplayAfterSplashScreen() {
    app.launch()

    let onboardingCollectionViews = app.collectionViews["onboarding-view"]
    let onboardingElements = onboardingCollectionViews
      .cells
      .children(matching: .other)
      .element.children(matching: .other)
      .element
    onboardingElements.swipeLeft()
    onboardingElements.swipeLeft()
    onboardingElements.swipeLeft()
    onboardingElements.buttons["onboarding-button"].tap()

    XCTAssert(app.navigationBars["Dinner Recipes"].exists)
  }
}
