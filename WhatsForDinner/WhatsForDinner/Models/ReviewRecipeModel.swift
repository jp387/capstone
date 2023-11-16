//
//  RecipeReviewModel.swift
//  LastMinuteMeals
//
//  Created by John Phung on 11/15/23.
//

import Foundation

struct Reviews: Codable {
  var reviews: [Review]
}

struct Review: Codable, Hashable, Identifiable {
  let id: UUID
  let recipeId: Int
  let rating: Int
  let comment: String
  let date: String

  enum CodingKeys: CodingKey {
    case id, recipeId, rating, comment, date
  }
}
