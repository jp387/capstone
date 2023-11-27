//
//  RandomRecipeModel.swift
//  WhatsForDinner
//
//  Created by John Phung on 11/11/23.
//

import Foundation

struct Recipes: Codable, Hashable, Equatable {
  let recipes: [Recipe]
}

struct Search: Codable, Hashable, Equatable {
  let results: [Recipe]
  let offset, number, totalResults: Int
}

struct Recipe: Codable, Hashable, Equatable, Identifiable {
  let pricePerServing: Double
  let extendedIngredients: [ExtendedIngredient]
  let id: Int
  let title: String
  let readyInMinutes, servings: Int
  let summary: String
  let instructions: String?
  let analyzedInstructions: [AnalyzedInstruction]
}

struct AnalyzedInstruction: Codable, Hashable, Equatable {
  let name: String
  let steps: [Step]
}

struct Step: Codable, Hashable, Equatable {
  let number: Int
  let step: String
  let ingredients, equipment: [Ent]
  let length: Length?
}

struct Ent: Codable, Hashable, Equatable {
  let id: Int
  let name, localizedName, image: String
}

struct Length: Codable, Hashable, Equatable {
  let number: Int
  let unit: String
}

struct ExtendedIngredient: Codable, Hashable, Equatable {
  let id: Int?
  let aisle: String?
  let consistency: Consistency?
  let name, original, originalName: String?
  let amount: Double?
  let unit: String?
  let meta: [String]?
  let measures: Measures?
}

enum Consistency: String, Codable, Hashable, Equatable {
  case liquid = "LIQUID"
  case solid = "SOLID"
}

struct Measures: Codable, Hashable, Equatable {
  let usa, metric: Metric
  enum CodingKeys: String, CodingKey {
    case usa = "us"
    case metric
  }
}

struct Metric: Codable, Hashable, Equatable {
  let amount: Double
  let unitShort, unitLong: String
}
