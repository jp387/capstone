//
//  RecipeMockModel.swift
//  WhatsForDinner
//
//  Created by John Phung on 11/27/23.
//

import Foundation

struct RecipesMock: Codable {
  let recipes: [RecipeMock]
}

struct SearchMock: Codable {
  let results: [Recipe]
  let offset, number, totalResults: Int
}

struct RecipeMock: Codable, Hashable, Equatable {
  let pricePerServing: Double
//  let extendedIngredients: [ExtendedIngredient]
  let id: Int
  let title: String
  let readyInMinutes, servings: Int
  let summary: String
//  let instructions: String?
//  let analyzedInstructions: [AnalyzedInstruction]
}

//struct AnalyzedInstruction: Codable {
//  let name: String
//  let steps: [Step]
//}
//
//struct Step: Codable {
//  let number: Int
//  let step: String
//  let ingredients, equipment: [Ent]
//  let length: Length?
//}
//
//struct Ent: Codable {
//  let id: Int
//  let name, localizedName, image: String
//}
//
//struct Length: Codable {
//  let number: Int
//  let unit: String
//}
//
//struct ExtendedIngredient: Codable {
//  let id: Int?
//  let aisle: String?
//  let consistency: Consistency?
//  let name, original, originalName: String?
//  let amount: Double?
//  let unit: String?
//  let meta: [String]?
//  let measures: Measures?
//}
//
//enum Consistency: String, Codable {
//  case liquid = "LIQUID"
//  case solid = "SOLID"
//}
//
//struct Measures: Codable {
//  let usa, metric: Metric
//  enum CodingKeys: String, CodingKey {
//    case usa = "us"
//    case metric
//  }
//}
//
//struct Metric: Codable {
//  let amount: Double
//  let unitShort, unitLong: String
//}
