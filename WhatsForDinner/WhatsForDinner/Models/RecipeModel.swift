//
//  RandomRecipeModel.swift
//  WhatsForDinner
//
//  Created by John Phung on 11/11/23.
//

import Foundation
import SwiftUI

struct Recipes: Codable, Hashable, Equatable {
  let recipes: [Recipe]
}

struct Search: Codable, Hashable, Equatable {
  let results: [Recipe]
  let offset: Int
  let number: Int
  let totalResults: Int
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

  var thumbnailURL: URL? {
    URL(string: "https://spoonacular.com/recipeImages/\(id)-90x90.jpg")
  }

  var fullImageURL: URL? {
    URL(string: "https://spoonacular.com/recipeImages/\(id)-480x360.jpg")
  }

  var pricePerServingCost: Double {
    return Double(pricePerServing / 100.0)
  }

  @ViewBuilder var cardCookingTime: some View {
    let hours = Int(readyInMinutes / 60)
    let minutes = Int(readyInMinutes - (hours * 60))

    if readyInMinutes >= 60 {
      let hoursText = hours > 1 ? "hours" : "hour"

      if minutes == 0 || minutes == 60 {
        Text("Cooking Time: \(hours) \(hoursText)")
          .foregroundColor(Color("CardTextColor"))
          .font(.caption)
      } else if minutes == 1 {
        Text("Cooking Time: \(hours) \(hoursText) \(minutes) minute")
          .foregroundColor(Color("CardTextColor"))
          .font(.caption)
      } else {
        Text("Cooking Time: \(hours) \(hoursText) \(minutes) minutes")
          .foregroundColor(Color("CardTextColor"))
          .font(.caption)
      }
    } else if readyInMinutes == 1 {
      Text("Cooking Time: \(readyInMinutes) minute")
        .foregroundColor(Color("CardTextColor"))
        .font(.caption)
    } else {
      Text("Cooking Time: \(readyInMinutes) minutes")
        .foregroundColor(Color("CardTextColor"))
        .font(.caption)
    }
  }

  @ViewBuilder var cookingTime: some View {
    let hours = Int(readyInMinutes / 60)
    let minutes = Int(readyInMinutes - (hours * 60))

    if readyInMinutes >= 60 {
      let hoursText = hours > 1 ? "hours" : "hour"
      if minutes == 0 || minutes == 60 {
        Text("Ready in \(hours) \(hoursText)")
          .font(.subheadline)
      } else if minutes == 1 {
        Text("Ready in \(hours) \(hoursText) \(minutes) minute")
          .font(.subheadline)
      } else {
        Text("Ready in \(hours) \(hoursText) \(minutes) minutes")
          .font(.subheadline)
      }
    } else if readyInMinutes == 1 {
      Text("Cooking Time: \(readyInMinutes) minute")
        .foregroundColor(Color("CardTextColor"))
        .font(.caption)
    } else {
      Text("Ready in \(readyInMinutes) minutes")
        .font(.subheadline)
    }
  }
}

struct AnalyzedInstruction: Codable, Hashable, Equatable {
  let name: String
  let steps: [Step]
}

struct Step: Codable, Hashable, Equatable {
  let number: Int
  let step: String
  let ingredients: [Ent]
  let equipment: [Ent]
  let length: Length?
}

struct Ent: Codable, Hashable, Equatable {
  let id: Int
  let name: String
  let localizedName: String
  let image: String
}

struct Length: Codable, Hashable, Equatable {
  let number: Int
  let unit: String
}

struct ExtendedIngredient: Codable, Hashable, Equatable {
  let id: Int?
  let aisle: String?
  let consistency: Consistency?
  let name: String?
  let original: String?
  let originalName: String?
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
  let usa: Metric
  let metric: Metric
  enum CodingKeys: String, CodingKey {
    case usa = "us"
    case metric
  }
}

struct Metric: Codable, Hashable, Equatable {
  let amount: Double
  let unitShort: String
  let unitLong: String
}
