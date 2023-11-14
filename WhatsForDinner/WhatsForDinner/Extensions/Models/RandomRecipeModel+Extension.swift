//
//  RandomRecipeModel+Extension.swift
//  WhatsForDinner
//
//  Created by John Phung on 11/13/23.
//

import Foundation

extension Recipe: Identifiable, Hashable {
  var identifier: String {
    return UUID().uuidString
  }

  static func == (lhs: Recipe, rhs: Recipe) -> Bool {
    return lhs.identifier == rhs.identifier
  }

  func hash(into hasher: inout Hasher) {
    hasher.combine(identifier)
  }
}

extension Recipe {
  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)
    vegetarian = try values.decode(Bool.self, forKey: .vegetarian)
    vegan = try values.decode(Bool.self, forKey: .vegan)
    glutenFree = try values.decode(Bool.self, forKey: .glutenFree)
    dairyFree = try values.decode(Bool.self, forKey: .dairyFree)
    veryHealthy = try values.decode(Bool.self, forKey: .veryHealthy)
    cheap = try values.decode(Bool.self, forKey: .cheap)
    veryPopular = try values.decode(Bool.self, forKey: .veryPopular)
    sustainable = try values.decode(Bool.self, forKey: .sustainable)
    lowFodmap = try values.decode(Bool.self, forKey: .lowFodmap)
    weightWatcherSmartPoints = try values.decode(Int.self, forKey: .weightWatcherSmartPoints)
    gaps = try values.decodeIfPresent(String.self, forKey: .gaps) ?? ""
    preparationMinutes = try values.decode(Int.self, forKey: .preparationMinutes)
    cookingMinutes = try values.decode(Int.self, forKey: .cookingMinutes)
    aggregateLikes = try values.decode(Int.self, forKey: .aggregateLikes)
    healthScore = try values.decode(Int.self, forKey: .healthScore)
    creditsText = try values.decodeIfPresent(String.self, forKey: .creditsText) ?? ""
    license = try values.decodeIfPresent(String.self, forKey: .license) ?? ""
    sourceName = try values.decodeIfPresent(String.self, forKey: .sourceName) ?? ""
    pricePerServing = try values.decode(Double.self, forKey: .pricePerServing)
    extendedIngredients = try values.decode([ExtendedIngredient].self, forKey: .extendedIngredients)
    id = try values.decode(Int.self, forKey: .id)
    title = try values.decodeIfPresent(String.self, forKey: .title) ?? ""
    readyInMinutes = try values.decode(Int.self, forKey: .readyInMinutes)
    servings = try values.decode(Int.self, forKey: .servings)
    sourceURL = try values.decodeIfPresent(String.self, forKey: .sourceURL) ?? ""
    image = try values.decodeIfPresent(String.self, forKey: .image) ?? ""
    summary = try values.decodeIfPresent(String.self, forKey: .summary) ?? ""
    dishTypes = try values.decodeIfPresent([String].self, forKey: .dishTypes) ?? []
    diets = try values.decodeIfPresent([String].self, forKey: .diets) ?? []
    instructions = try values.decodeIfPresent(String.self, forKey: .instructions) ?? ""
    analyzedInstructions = try values.decode([AnalyzedInstruction].self, forKey: .analyzedInstructions)
    spoonacularScore = try values.decode(Double.self, forKey: .spoonacularScore)
    spoonacularSourceURL = try values.decodeIfPresent(String.self, forKey: .spoonacularSourceURL) ?? ""
  }
}

extension AnalyzedInstruction {
  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)
    name = try values.decodeIfPresent(String.self, forKey: .name) ?? ""
    steps = try values.decode([Step].self, forKey: .steps)
  }
}

extension Step {
  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)
    number = try values.decode(Int.self, forKey: .number)
    step = try values.decodeIfPresent(String.self, forKey: .step) ?? ""
    ingredients = try values.decode([Ent].self, forKey: .ingredients)
    equipment = try values.decode([Ent].self, forKey: .equipment)
    length = try values.decodeIfPresent(Length.self, forKey: .length) ?? Length(number: 0, unit: "minutes")
  }
}

extension Ent {
  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)
    id = try values.decode(Int.self, forKey: .id)
    name = try values.decodeIfPresent(String.self, forKey: .name) ?? ""
    localizedName = try values.decodeIfPresent(String.self, forKey: .localizedName) ?? ""
    image = try values.decodeIfPresent(String.self, forKey: .image) ?? ""
  }
}

extension Length {
  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)
    number = try values.decode(Int.self, forKey: .number)
    unit = try values.decodeIfPresent(String.self, forKey: .unit) ?? ""
  }
}

extension ExtendedIngredient {
  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)
    id = try values.decode(Int.self, forKey: .id)
    aisle = try values.decodeIfPresent(String.self, forKey: .aisle) ?? ""
    consistency = try values.decode(Consistency.self, forKey: .consistency)
    name = try values.decodeIfPresent(String.self, forKey: .name) ?? ""
    original = try values.decodeIfPresent(String.self, forKey: .original) ?? ""
    originalName = try values.decodeIfPresent(String.self, forKey: .orignalName) ?? ""
    amount = try values.decode(Double.self, forKey: .amount)
    unit = try values.decodeIfPresent(String.self, forKey: .unit) ?? ""
    meta = try values.decodeIfPresent([String].self, forKey: .meta) ?? []
    measures = try values.decode(Measures.self, forKey: .measures)
  }

  func encode(to encoder: Encoder) throws { }
}

extension Metric {
  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)
    amount = try values.decode(Double.self, forKey: .amount)
    unitShort = try values.decodeIfPresent(String.self, forKey: .unitShort) ?? ""
    unitLong = try values.decodeIfPresent(String.self, forKey: .unitLong) ?? ""
  }
}
