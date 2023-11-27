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
    randomRecipeVM = RandomRecipeViewModel(service: RecipeService())
    try super.setUpWithError()
  }

  override func tearDownWithError() throws {
    randomRecipeVM = nil
    try super.tearDownWithError()
  }

  func test_randomRecipeIsNotEmpty() async throws {
    try await randomRecipeVM.fetchRandomRecipe()
    XCTAssertGreaterThanOrEqual(randomRecipeVM.recipes.count, 1)
  }

  func test_randomRecipeRefreshFetchNewRecipes() async throws {
    try await randomRecipeVM.refreshRandomRecipe()
    XCTAssertGreaterThanOrEqual(randomRecipeVM.recipes.count, 1)
  }

  func test_randomRecipeLoadFromBundle() {
    randomRecipeVM.fetchBundleRecipe()
    XCTAssertGreaterThanOrEqual(randomRecipeVM.recipes.count, 1)
  }
}
