//
//  RandomRecipeModel.swift
//  LastMinuteMeals
//
//  Created by John Phung on 11/11/23.
//

import Foundation

struct Recipes: Codable {
  let recipes: [Recipe]
}

struct Recipe: Codable {
  let vegetarian, vegan, glutenFree, dairyFree: Bool
  let veryHealthy, cheap, veryPopular, sustainable: Bool
  let lowFodmap: Bool
  let weightWatcherSmartPoints: Int
  let gaps: String
  let preparationMinutes, cookingMinutes, aggregateLikes, healthScore: Int
  let creditsText: String
  let license: String
  let sourceName: String
  let pricePerServing: Double
  let extendedIngredients: [ExtendedIngredient]
  let id: Int
  let title: String
  let readyInMinutes, servings: Int
  let sourceURL: String
  let image: String
  let imageType: String
  let summary: String
  let dishTypes, diets: [String]
  let instructions: String
  let analyzedInstructions: [AnalyzedInstruction]
  let spoonacularScore: Double
  let spoonacularSourceURL: String
  enum CodingKeys: String, CodingKey {
    case vegetarian, vegan, glutenFree, dairyFree, veryHealthy, cheap, veryPopular, sustainable, lowFodmap,
      weightWatcherSmartPoints, gaps, preparationMinutes, cookingMinutes, aggregateLikes, healthScore,
      creditsText, license, sourceName, pricePerServing, extendedIngredients, id, title, readyInMinutes,
      servings
    case sourceURL = "sourceUrl"
    case image, imageType, summary, dishTypes, diets, instructions, analyzedInstructions
    case spoonacularScore
    case spoonacularSourceURL = "spoonacularSourceUrl"
  }
}

struct AnalyzedInstruction: Codable {
  let name: String
  let steps: [Step]
  enum CodingKeys: CodingKey {
    case name, steps
  }
}

struct Step: Codable {
  let number: Int
  let step: String
  let ingredients, equipment: [Ent]
  let length: Length
  enum CodingKeys: CodingKey {
    case number, step, ingredients, equipment, length
  }
}

struct Ent: Codable {
  let id: Int
  let name, localizedName, image: String
  enum CodingKeys: CodingKey {
    case id, name, localizedName, image
  }
}

struct Length: Codable {
  let number: Int
  let unit: String
  enum CodingKeys: CodingKey {
    case number, unit
  }
}

struct ExtendedIngredient: Codable {
  let id: Int
  let aisle: String
  let consistency: Consistency
  let name, original, originalName: String
  let amount: Double
  let unit: String
  let meta: [String]
  let measures: Measures
  enum CodingKeys: CodingKey {
    case id, aisle, consistency, name, original, orignalName, amount, unit, meta, measures
  }
}

enum Consistency: String, Codable {
  case liquid = "LIQUID"
  case solid = "SOLID"
}

struct Measures: Codable {
  let usa, metric: Metric
  enum CodingKeys: String, CodingKey {
    case usa = "us"
    case metric
  }
}

struct Metric: Codable {
  let amount: Double
  let unitShort, unitLong: String
  enum CodingKeys: CodingKey {
    case amount, unitShort, unitLong
  }
}
