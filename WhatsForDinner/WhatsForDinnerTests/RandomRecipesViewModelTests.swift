//
//  WhatsForDinnerTests.swift
//  WhatsForDinnerTests
//
//  Created by John Phung on 11/12/23.
//

import XCTest
@testable import WhatsForDinner

final class RandomRecipesViewModelTests: XCTestCase {
  // swiftlint:disable implicitly_unwrapped_optional
  var randomRecipeVM: RandomRecipeViewModel!
  // swiftlint:enable implicitly_unwrapped_optional

  override func setUpWithError() throws {
    randomRecipeVM = RandomRecipeViewModel()
    try super.setUpWithError()
  }

  override func tearDownWithError() throws {
    randomRecipeVM = nil
    try super.tearDownWithError()
  }

  @MainActor
  func test_randomRecipeIsNotEmpty() async {
    await randomRecipeVM.fetchRandomRecipe()
    XCTAssertGreaterThanOrEqual(randomRecipeVM.recipes.count, 1)
  }

  @MainActor
  func test_randomRecipeIsEmpty() async {
    XCTAssert(randomRecipeVM.showAlert)
  }

  @MainActor
  func test_randomRecipeRefreshFetchNewRecipes() async {
    await randomRecipeVM.refreshRandomRecipe()
    XCTAssertGreaterThanOrEqual(randomRecipeVM.recipes.count, 1)
  }

  func test_randomRecipeLoadFromBundle() {
    randomRecipeVM.fetchBundleRecipe()
    XCTAssertGreaterThanOrEqual(randomRecipeVM.recipes.count, 1)
  }
}
