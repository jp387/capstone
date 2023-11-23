//
//  ReviewRecipeViewModel.swift
//  WhatsForDinner
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
    } catch DecodingError.dataCorrupted(let context) {
      print("Data corrupted: \(context.debugDescription)")
    } catch DecodingError.keyNotFound(let key, let context) {
      print("Key '\(key.stringValue)' not found: \(context.debugDescription)")
    } catch DecodingError.typeMismatch(let type, let context) {
      print("Type mismatch for type \(type): \(context.debugDescription)")
    } catch DecodingError.valueNotFound(let type, let context) {
      print("Value not found for type \(type): \(context.debugDescription)")
    } catch {
      print("Other decoding error: \(error)")
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
    } catch {
      print(error.localizedDescription)
    }
  }
}
