//
//  SearchRecipeModel+Extension.swift
//  WhatsForDinner
//
//  Created by John Phung on 11/14/23.
//

import Foundation

extension Result: Identifiable, Hashable {
  var identifier: String {
    return UUID().uuidString
  }

  static func == (lhs: Result, rhs: Result) -> Bool {
    return lhs.identifier == rhs.identifier
  }

  func hash(into hasher: inout Hasher) {
    hasher.combine(identifier)
  }
}

extension Result {
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
    sourceName = try values.decodeIfPresent(String.self, forKey: .sourceName) ?? ""
    pricePerServing = try values.decode(Double.self, forKey: .pricePerServing)
    extendedIngredients = try values.decode([ResultEdIngredient].self, forKey: .extendedIngredients)
    id = try values.decode(Int.self, forKey: .id)
    title = try values.decodeIfPresent(String.self, forKey: .title) ?? ""
    readyInMinutes = try values.decode(Int.self, forKey: .readyInMinutes)
    servings = try values.decode(Int.self, forKey: .servings)
    sourceURL = try values.decodeIfPresent(String.self, forKey: .sourceURL) ?? ""
    image = try values.decodeIfPresent(String.self, forKey: .image) ?? ""
    imageType = try values.decodeIfPresent(String.self, forKey: .imageType) ?? ""
    nutrition = try values.decode(Nutrition.self, forKey: .nutrition)
    summary = try values.decodeIfPresent(String.self, forKey: .summary) ?? ""
    dishTypes = try values.decodeIfPresent([String].self, forKey: .dishTypes) ?? []
    diets = try values.decodeIfPresent([String].self, forKey: .diets) ?? []
    analyzedInstructions = try values.decode([ResultAnalyzedInstruction].self, forKey: .analyzedInstructions)
    spoonacularScore = try values.decode(Double.self, forKey: .spoonacularScore)
    spoonacularSourceURL = try values.decodeIfPresent(String.self, forKey: .spoonacularSourceURL) ?? ""
    usedIngredientCount = try values.decode(Int.self, forKey: .usedIngredientCount)
    missedIngredientCount = try values.decode(Int.self, forKey: .missedIngredientCount)
    missedIngredients = try values.decode([ResultEdIngredient].self, forKey: .missedIngredients)
  }
}

extension ResultAnalyzedInstruction {
  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)
    name = try values.decodeIfPresent(String.self, forKey: .name) ?? ""
    steps = try values.decode([ResultStep].self, forKey: .steps)
  }
}

extension ResultStep {
  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)
    number = try values.decode(Int.self, forKey: .number)
    step = try values.decodeIfPresent(String.self, forKey: .step) ?? ""
    ingredients = try values.decode([ResultEnt].self, forKey: .ingredients)
    equipment = try values.decode([ResultEnt].self, forKey: .equipment)
    length = try values.decodeIfPresent(Length.self, forKey: .length) ?? Length(number: 0, unit: "")
  }
}

extension ResultEnt {
  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)
    id = try values.decode(Int.self, forKey: .id)
    name = try values.decodeIfPresent(String.self, forKey: .name) ?? ""
    localizedName = try values.decodeIfPresent(String.self, forKey: .localizedName) ?? ""
    image = try values.decodeIfPresent(String.self, forKey: .image) ?? ""
    temperature = try values.decodeIfPresent(Length.self, forKey: .temperature) ?? Length(number: 0, unit: "")
  }
}

extension ResultLength {
  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)
    number = try values.decode(Int.self, forKey: .number)
    unit = try values.decodeIfPresent(String.self, forKey: .unit) ?? ""
  }
}

extension ResultEdIngredient {
  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)
    id = try values.decode(Int.self, forKey: .id)
    aisle = try values.decodeIfPresent(String.self, forKey: .aisle) ?? ""
    image = try values.decodeIfPresent(String.self, forKey: .image) ?? ""
    consistency = try values.decodeIfPresent(String.self, forKey: .consistency) ?? ""
    name = try values.decodeIfPresent(String.self, forKey: .name) ?? ""
    nameClean = try values.decodeIfPresent(String.self, forKey: .nameClean) ?? ""
    original = try values.decodeIfPresent(String.self, forKey: .original) ?? ""
    originalName = try values.decodeIfPresent(String.self, forKey: .originalName) ?? ""
    amount = try values.decode(Double.self, forKey: .amount)
    unit = try values.decodeIfPresent(String.self, forKey: .unit) ?? ""
    meta = try values.decodeIfPresent([String].self, forKey: .meta) ?? []
    measures = try values.decodeIfPresent(ResultMeasures.self, forKey: .measures)
    unitLong = try values.decodeIfPresent(String.self, forKey: .unitLong) ?? ""
    unitShort = try values.decodeIfPresent(String.self, forKey: .unitShort) ?? ""
  }
}

extension ResultMetric {
  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)
    amount = try values.decode(Double.self, forKey: .amount)
    unitShort = try values.decodeIfPresent(String.self, forKey: .unitShort) ?? ""
    unitLong = try values.decodeIfPresent(String.self, forKey: .unitLong) ?? ""
  }
}

extension Flavonoid {
  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)
    name = try values.decodeIfPresent(String.self, forKey: .name) ?? ""
    amount = try values.decode(Double.self, forKey: .amount)
    unit = try values.decode(Unit.self, forKey: .unit)
    percentOfDailyNeeds = try values.decodeIfPresent(Double.self, forKey: .percentOfDailyNeeds) ?? 0.0
  }
}

extension Ingredient {
  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)
    id = try values.decode(Int.self, forKey: .id)
    name = try values.decodeIfPresent(String.self, forKey: .name) ?? ""
    amount = try values.decode(Double.self, forKey: .amount)
    unit = try values.decodeIfPresent(String.self, forKey: .unit) ?? ""
    nutrients = try values.decode([Flavonoid].self, forKey: .nutrients)
  }
}
