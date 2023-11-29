//
//  ReviewRecipeViewModelTests.swift
//  WhatsForDinnerTests
//
//  Created by John Phung on 11/22/23.
//

import XCTest
@testable import WhatsForDinner

final class ReviewRecipeViewModelTests: XCTestCase {
  // The SwiftLint rule is disabled since the variable will be initialized in the setUp() method
  // swiftlint:disable implicitly_unwrapped_optional
  var reviewRecipeVM: ReviewRecipeViewModel!
  // swiftlint:enable implicitly_unwrapped_optional

  override func setUp() {
    reviewRecipeVM = ReviewRecipeViewModel()
  }

  func test_addRecipeReviews() {
    reviewRecipeVM.addReview(recipeId: 1, rating: 5, comment: "Good Recipe")
    XCTAssertGreaterThanOrEqual(reviewRecipeVM.review.count, 1)
  }
}
