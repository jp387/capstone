//
//  FavoriteRecipeViewModelTests.swift
//  WhatsForDinnerTests
//
//  Created by John Phung on 11/22/23.
//

import XCTest
@testable import WhatsForDinner

final class FavoriteRecipeViewModelTests: XCTestCase {
  // swiftlint:disable implicitly_unwrapped_optional
  var favoriteRecipeVM: FavoriteRecipeViewModel!
  var randomRecipeVM: RandomRecipeViewModel!
  // swiftlint:enable implicitly_unwrapped_optional

  override func setUpWithError() throws {
    favoriteRecipeVM = FavoriteRecipeViewModel()
    randomRecipeVM = RandomRecipeViewModel(service: RecipeService())
    try super.setUpWithError()
  }

  override func tearDownWithError() throws {
    favoriteRecipeVM = nil
    try super.tearDownWithError()
  }

  func test_loadFavoriteRecipesSuccess() {
    XCTAssertNoThrow(favoriteRecipeVM.favorite.isEmpty)
  }

  func test_favoriteRecipesIsFound() {
    let recipeExist = favoriteRecipeVM.containsFavorite(for: 1)
    XCTAssert(recipeExist)
  }

  func test_addFavoriteRecipeSuccess() {
    randomRecipeVM.fetchBundleRecipe()
    if let firstRecipe = randomRecipeVM.recipes.first {
      favoriteRecipeVM.addFavorite(recipeId: 1, title: "Maccaroni with Cheese", recipe: firstRecipe)
    }
    XCTAssertGreaterThan(favoriteRecipeVM.favorite.count, 1)
  }

  func test_removeFavoriteRecipeSuccess() {
    let recipeId = 1
    favoriteRecipeVM.removeFavorite(by: recipeId)
    let index = favoriteRecipeVM.favorite.firstIndex { $0.recipeId == recipeId }
    XCTAssertNil(index)
  }
}
