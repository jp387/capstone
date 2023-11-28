//
//  WhatsForDinnerTests.swift
//  WhatsForDinnerTests
//
//  Created by John Phung on 11/12/23.
//

import XCTest
@testable import WhatsForDinner

final class RandomRecipesViewModelTests: XCTestCase {
  // The SwiftLint rule is disabled since the variable will be initialized in the setUp() method
  // swiftlint:disable implicitly_unwrapped_optional
  var randomRecipeVM: RandomRecipeViewModel!
  // swiftlint:enable implicitly_unwrapped_optional
  var mockRecipes: [Recipe] = []

  override func setUp() {
    randomRecipeVM = RandomRecipeViewModel(service: RecipeMockService())

    if let recipeURL =
      Bundle.main.url(forResource: "mockrecipes", withExtension: "json") {
      do {
        let recipeData = try Data(contentsOf: recipeURL)
        mockRecipes = try JSONDecoder().decode(Recipes.self, from: recipeData).recipes
      } catch { }
    }
  }

  func test_randomRecipeFetchCorrectData() async throws {
    XCTAssertFalse(randomRecipeVM.isLoading)
    XCTAssertEqual(randomRecipeVM.recipes, [])
    XCTAssertNil(randomRecipeVM.error)

    try await randomRecipeVM.fetchRandomRecipe()

    XCTAssertFalse(randomRecipeVM.isLoading)
    XCTAssertEqual(randomRecipeVM.recipes, mockRecipes)

    XCTAssertNil(randomRecipeVM.error)
  }

  func test_randomRecipeRefreshCorrectData() async throws {
    XCTAssertFalse(randomRecipeVM.isLoading)
    XCTAssertEqual(randomRecipeVM.recipes, [])
    XCTAssertNil(randomRecipeVM.error)

    try await randomRecipeVM.refreshRandomRecipe()

    XCTAssertFalse(randomRecipeVM.isLoading)
    XCTAssertEqual(randomRecipeVM.recipes, mockRecipes)
    XCTAssertNil(randomRecipeVM.error)
  }

  func test_randomRecipeLoadsEmptyData() async throws {
    randomRecipeVM = RandomRecipeViewModel(service: RecipeEmptyMockService())
    XCTAssertFalse(randomRecipeVM.isLoading)
    XCTAssertEqual(randomRecipeVM.recipes, [])
    XCTAssertNil(randomRecipeVM.error)

    try await randomRecipeVM.fetchRandomRecipe()

    XCTAssertFalse(randomRecipeVM.isLoading)
    XCTAssertEqual(randomRecipeVM.recipes, [])
    XCTAssert(randomRecipeVM.showAlert)
  }

  func test_randomRecipeRefreshEmptyData() async throws {
    randomRecipeVM = RandomRecipeViewModel(service: RecipeEmptyMockService())
    XCTAssertFalse(randomRecipeVM.isLoading)
    XCTAssertEqual(randomRecipeVM.recipes, [])
    XCTAssertNil(randomRecipeVM.error)

    try await randomRecipeVM.refreshRandomRecipe()

    XCTAssertFalse(randomRecipeVM.isLoading)
    XCTAssertEqual(randomRecipeVM.recipes, [])
    XCTAssert(randomRecipeVM.showAlert)
  }

  func test_randomRecipeBundleFetchCorrectData() {
    randomRecipeVM = RandomRecipeViewModel(service: RecipeService())
    XCTAssertFalse(randomRecipeVM.isLoading)
    XCTAssertEqual(randomRecipeVM.recipes, [])
    XCTAssertFalse(randomRecipeVM.isBundle)
    XCTAssertNil(randomRecipeVM.error)

    randomRecipeVM.fetchBundleRecipe(for: "recipestub")

    XCTAssertNotEqual(randomRecipeVM.recipes, [])
    XCTAssertFalse(randomRecipeVM.isLoading)
    XCTAssertFalse(randomRecipeVM.showAlert)
  }

  func test_randomRecipeBundleLoadError() {
    randomRecipeVM = RandomRecipeViewModel(service: RecipeService())
    XCTAssertFalse(randomRecipeVM.isLoading)
    XCTAssertEqual(randomRecipeVM.recipes, [])
    XCTAssertFalse(randomRecipeVM.isBundle)
    XCTAssertNil(randomRecipeVM.error)

    randomRecipeVM.fetchBundleRecipe(for: "recipestub1")

    XCTAssertFalse(randomRecipeVM.isLoading)
    XCTAssert(randomRecipeVM.showAlert)
  }

  func test_randomRecipeEmptyBundleError() {
    randomRecipeVM = RandomRecipeViewModel(service: RecipeEmptyMockService())
    XCTAssertFalse(randomRecipeVM.isLoading)
    XCTAssertEqual(randomRecipeVM.recipes, [])
    XCTAssertFalse(randomRecipeVM.isBundle)
    XCTAssertNil(randomRecipeVM.error)

    randomRecipeVM.fetchBundleRecipe(for: "emptyrecipe")

    XCTAssertEqual(randomRecipeVM.recipes, [])
    XCTAssertFalse(randomRecipeVM.isLoading)
    XCTAssert(randomRecipeVM.showAlert)
  }

  func test_randomRecipeBundleDecodeError() {
    randomRecipeVM = RandomRecipeViewModel(service: RecipeMockService())
    XCTAssertFalse(randomRecipeVM.isLoading)
    XCTAssertEqual(randomRecipeVM.recipes, [])
    XCTAssertFalse(randomRecipeVM.isBundle)
    XCTAssertNil(randomRecipeVM.error)

    randomRecipeVM.fetchBundleRecipe(for: "titlenullrecipes")

    XCTAssertFalse(randomRecipeVM.isLoading)
    XCTAssert(randomRecipeVM.showAlert)
  }
}
