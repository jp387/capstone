//
//  WhatsForDinnerTests.swift
//  WhatsForDinnerTests
//
//  Created by John Phung on 11/12/23.
//

import XCTest
@testable import WhatsForDinner

final class RandomRecipesViewModelTests: XCTestCase {
  var randomRecipeVM: RandomRecipeViewModel!

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
  func test_randomRecipeRefreshFetchNewRecipes() async {
    await randomRecipeVM.refreshRandomRecipe()
    XCTAssertGreaterThanOrEqual(randomRecipeVM.recipes.count, 1)
  }

  func test_randomRecipeLoadFromBundle() {
    randomRecipeVM.fetchBundleRecipe()
    XCTAssertGreaterThanOrEqual(randomRecipeVM.recipes.count, 1)
  }
}
