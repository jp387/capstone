//
//  SearchRecipeViewModelTests.swift
//  WhatsForDinnerTests
//
//  Created by John Phung on 11/22/23.
//

import XCTest
@testable import WhatsForDinner

final class SearchRecipeViewModelTests: XCTestCase {
  // The SwiftLint rule is disabled since the variable will be initialized in the setUp() method
  // swiftlint:disable implicitly_unwrapped_optional
  var searchRecipeVM: SearchRecipeViewModel!
  // swiftlint:enable implicitly_unwrapped_optional
  var mockResults: [Recipe] = []

  override func setUp() {
    searchRecipeVM = SearchRecipeViewModel(service: RecipeMockService())

    if let recipeURL =
      Bundle.main.url(forResource: "searchresultrecipes", withExtension: "json") {
      do {
        let recipeData = try Data(contentsOf: recipeURL)
        mockResults = try JSONDecoder().decode(Recipes.self, from: recipeData).recipes
      } catch { }
    }
  }

  func test_searchRecipeSuccess() async {
    XCTAssertFalse(searchRecipeVM.isLoading)
    XCTAssertEqual(searchRecipeVM.results, [])
    XCTAssertNil(searchRecipeVM.error)

    await searchRecipeVM.fetchSearchResults(for: "Bacon")

    XCTAssertFalse(searchRecipeVM.isLoading)
    XCTAssertEqual(searchRecipeVM.results, mockResults)
    XCTAssertNil(searchRecipeVM.error)
  }

  func test_searchRecipeFailure() async {
    XCTAssertFalse(searchRecipeVM.isLoading)
    XCTAssertEqual(searchRecipeVM.results, [])
    XCTAssertNil(searchRecipeVM.error)

    await searchRecipeVM.fetchSearchResults(for: "John")

    XCTAssertFalse(searchRecipeVM.isLoading)
    XCTAssertEqual(searchRecipeVM.results, [])
    XCTAssert(searchRecipeVM.noResults)
  }

  func test_searchRecipeError() async {
    searchRecipeVM = SearchRecipeViewModel(service: RecipeEmptyMockService())
    XCTAssertFalse(searchRecipeVM.isLoading)
    XCTAssertEqual(searchRecipeVM.results, [])
    XCTAssertNil(searchRecipeVM.error)

    await searchRecipeVM.fetchSearchResults(for: "John")

    XCTAssertFalse(searchRecipeVM.isLoading)
    XCTAssertEqual(searchRecipeVM.results, [])
    XCTAssertNil(searchRecipeVM.error)
    XCTAssert(searchRecipeVM.showAlertPrompt)
  }
}
