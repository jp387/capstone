//
//  NewRecipeReviewVM.swift
//  LastMinuteMeals
//
//  Created by John Phung on 11/16/23.
//

import Foundation

class ReviewRecipeViewModel: ObservableObject {
  @Published var review: [Review] = [] {
    didSet {
      saveReviews()
    }
  }

  let reviewsURL = URL(
    filePath: "reviews",
    relativeTo: FileManager.documentDirectoryURL
  ).appendingPathExtension("json")

  init() {
    loadReviews()
  }

  private func loadReviews() {
    let decoder = JSONDecoder()

    do {
      let data = try Data(contentsOf: reviewsURL)
      review = try decoder.decode(Reviews.self, from: data).reviews
    } catch {
      print(error.localizedDescription)
    }
  }

  func addReview(id: UUID = UUID(), recipeId: Int, rating: Int, comment: String, date: String = Date().description) {
    let newReview = Review(id: id, recipeId: recipeId, rating: rating, comment: comment, date: date)
    review.append(newReview)
  }

  private func saveReviews() {
    let encoder = JSONEncoder()
    encoder.outputFormatting = [.prettyPrinted, .withoutEscapingSlashes, .sortedKeys]

    let reviewsData = Reviews(reviews: review)

    do {
      let data = try encoder.encode(reviewsData)
      try data.write(to: reviewsURL, options: .atomicWrite)
    } catch let error {
      print(error.localizedDescription)
    }
  }
}
