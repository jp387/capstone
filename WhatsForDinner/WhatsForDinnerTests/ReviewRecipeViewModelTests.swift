//
//  ReviewRecipeViewModelTests.swift
//  WhatsForDinnerTests
//
//  Created by John Phung on 11/22/23.
//

import XCTest
@testable import WhatsForDinner

final class ReviewRecipeViewModelTests: XCTestCase {
  // swiftlint:disable implicitly_unwrapped_optional
  var reviewRecipeVM: ReviewRecipeViewModel!
  var randomRecipeVM: RandomRecipeViewModel!
  // swiftlint:enable implicitly_unwrapped_optional

  override func setUpWithError() throws {
    reviewRecipeVM = ReviewRecipeViewModel()
    randomRecipeVM = RandomRecipeViewModel()
    try super.setUpWithError()
  }

  override func tearDownWithError() throws {
    reviewRecipeVM = nil
    randomRecipeVM = nil
    try super.tearDownWithError()
  }

  func test_loadReviewFromDocumentDirectory() {
    if reviewRecipeVM.review.isEmpty {
      XCTAssert(reviewRecipeVM.review.isEmpty)
    } else {
      XCTAssertFalse(reviewRecipeVM.review.isEmpty)
      XCTAssertGreaterThanOrEqual(reviewRecipeVM.review.count, 1)
    }
  }

  func test_addRecipeReviews() {
    reviewRecipeVM.addReview(recipeId: 1, rating: 5, comment: "Good Recipe")
    XCTAssertGreaterThanOrEqual(reviewRecipeVM.review.count, 1)
  }
}
