//
//  RecipeSearchModel.swift
//  LastMinuteMeals
//
//  Created by John Phung on 11/11/23.
//

import Foundation

struct Search: Codable {
  let results: [Result]
  let offset, number, totalResults: Int
}

struct Result: Codable {
  let vegetarian, vegan, glutenFree, dairyFree: Bool
  let veryHealthy, cheap, veryPopular, sustainable: Bool
  let lowFodmap: Bool
  let weightWatcherSmartPoints: Int
  let gaps: String
  let preparationMinutes, cookingMinutes, aggregateLikes, healthScore: Int
  let creditsText, sourceName: String
  let pricePerServing: Double
  let extendedIngredients: [ResultEdIngredient]
  let id: Int
  let title: String
  let readyInMinutes, servings: Int
  let sourceURL: String
  let image: String
  let imageType: String
  let nutrition: Nutrition
  let summary: String
  let dishTypes, diets: [String]
  let analyzedInstructions: [ResultAnalyzedInstruction]
  let spoonacularScore: Double
  let spoonacularSourceURL: String
  let usedIngredientCount, missedIngredientCount: Int
  let missedIngredients: [ResultEdIngredient]
  enum CodingKeys: String, CodingKey {
    case vegetarian, vegan, glutenFree, dairyFree, veryHealthy, cheap, veryPopular, sustainable, lowFodmap,
      weightWatcherSmartPoints, gaps, preparationMinutes, cookingMinutes, aggregateLikes, healthScore,
      creditsText, sourceName, pricePerServing, extendedIngredients, id, title, readyInMinutes, servings
    case sourceURL = "sourceUrl"
    case image, imageType, nutrition, summary, dishTypes, diets, analyzedInstructions, spoonacularScore
    case spoonacularSourceURL = "spoonacularSourceUrl"
    case usedIngredientCount, missedIngredientCount, missedIngredients
  }
}

struct ResultAnalyzedInstruction: Codable {
  let name: String
  let steps: [ResultStep]
  enum CodingKeys: CodingKey {
    case name, steps
  }
}

struct ResultStep: Codable {
  let number: Int
  let step: String
  let ingredients, equipment: [ResultEnt]
  let length: Length
  enum CodingKeys: CodingKey {
    case number, step, ingredients, equipment, length
  }
}

struct ResultEnt: Codable {
  let id: Int
  let name, localizedName, image: String
  let temperature: Length
  enum CodingKeys: CodingKey {
    case id, name, localizedName, image, temperature
  }
}

struct ResultLength: Codable {
  let number: Int
  let unit: String
  enum CodingKeys: CodingKey {
    case number, unit
  }
}

struct ResultEdIngredient: Codable {
  let id: Int
  let aisle: String
  let image: String
  let consistency: String
  let name: String
  let nameClean: String
  let original, originalName: String
  let amount: Double
  let unit: String
  let meta: [String]
  let measures: ResultMeasures?
  let unitLong, unitShort: String
  enum CodingKeys: CodingKey {
    case id, aisle, image, consistency, name, nameClean, original,
      originalName, amount, unit, meta, measures, unitLong, unitShort
  }
}

struct ResultMeasures: Codable {
  let usa, metric: ResultMetric
  enum CodingKeys: String, CodingKey {
    case usa = "us"
    case metric
  }
}

struct ResultMetric: Codable {
  let amount: Double
  let unitShort, unitLong: String
  enum CodingKeys: CodingKey {
    case amount, unitShort, unitLong
  }
}

struct Nutrition: Codable {
  let nutrients, properties, flavonoids: [Flavonoid]
  let ingredients: [Ingredient]
  let caloricBreakdown: CaloricBreakdown
  let weightPerServing: WeightPerServing
}

struct CaloricBreakdown: Codable {
  let percentProtein, percentFat, percentCarbs: Double
}

struct Flavonoid: Codable {
  let name: String
  let amount: Double
  let unit: Unit
  let percentOfDailyNeeds: Double?
  enum CodingKeys: CodingKey {
    case name, amount, unit, percentOfDailyNeeds
  }
}

enum Unit: String, Codable {
  case empty = ""
  case grams = "g"
  case ius = "IU"
  case kcal = "kcal"
  case mgs = "mg"
  case unit = "%"
  case µgs = "µg"
}

struct Ingredient: Codable {
  let id: Int
  let name: String
  let amount: Double
  let unit: String
  let nutrients: [Flavonoid]
  enum CodingKeys: CodingKey {
    case id, name, amount, unit, nutrients
  }
}

struct WeightPerServing: Codable {
  let amount: Int
  let unit: Unit
}
