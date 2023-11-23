//
//  SearchRecipeViewModelTests.swift
//  WhatsForDinnerTests
//
//  Created by John Phung on 11/22/23.
//

import XCTest
@testable import WhatsForDinner

final class SearchRecipeViewModelTests: XCTestCase {
  // swiftlint:disable implicitly_unwrapped_optional
  var searchRecipeVM: SearchRecipeViewModel!
  // swiftlint:enable implicitly_unwrapped_optional

  override func setUpWithError() throws {
    searchRecipeVM = SearchRecipeViewModel()
    try super.setUpWithError()
  }

  override func tearDownWithError() throws {
    searchRecipeVM = nil
    try super.tearDownWithError()
  }

  func test_searchRecipeSuccess() async {
    await searchRecipeVM.fetchSearchResults(for: "Chicken")
    XCTAssertFalse(searchRecipeVM.results.isEmpty)
  }

  func test_searchRecipeFailure() async {
    await searchRecipeVM.fetchSearchResults(for: "John")
    XCTAssert(searchRecipeVM.results.isEmpty)
    XCTAssert(searchRecipeVM.noResults)
  }
}
