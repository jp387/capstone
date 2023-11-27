//
//  RecipeMockService.swift
//  WhatsForDinner
//
//  Created by John Phung on 11/26/23.
//

import Foundation

struct RecipeMockService: RecipeServiceProtocol {
  var recipes: [Recipe] = [
    Recipe(
      pricePerServing: 141.03,
      extendedIngredients: [
        ExtendedIngredient(
          id: 1145,
          aisle: "Milk, Eggs, Other Dairy",
          consistency: Consistency(rawValue: "SOLID"),
          name: "butter",
          original: "2 tablespoons butter",
          originalName: "unsalted butter",
          amount: Double(2),
          unit: "tablespoons",
          meta: [
            "unsalted",
            "melted"
          ],
          measures: Measures(
            usa: Metric(
              amount: Double(2),
              unitShort: "Tbsps",
              unitLong: "Tbsps"),
            metric: Metric(
              amount: Double(2),
              unitShort: "Tbsps",
              unitLong: "Tbsps")
          )
        )
      ],
      id: 633265,
      title: "Bacon & Egg Toast Cups",
      readyInMinutes: 45,
      servings: 2,
      summary: "Bacon & Egg Toast Cups takes 45 minutes.",
      instructions: "Preheat oven to 375.",
      analyzedInstructions: [
        AnalyzedInstruction(
          name: "",
          steps: [
            Step(
              number: 1,
              step: "Preheat oven to 37",
              ingredients: [],
              equipment: [
                Ent(
                  id: 404784,
                  name: "oven",
                  localizedName: "oven",
                  image: "oven.jpg"
                )
              ],
              length: nil)
          ])
      ]
    ),
    Recipe(
      pricePerServing: 27.49,
      extendedIngredients: [
        ExtendedIngredient(
          id: 18369,
          aisle: "Baking",
          consistency: Consistency(rawValue: "SOLID"),
          name: "baking powder",
          original: "3/4 teaspoon baking powder",
          originalName: "baking powder",
          amount: 0.75,
          unit: "teaspoon",
          meta: [],
          measures: Measures(
            usa: Metric(
              amount: 0.75,
              unitShort: "tsps",
              unitLong: "teaspoons"),
            metric: Metric(
              amount: 0.75,
              unitShort: "tsps",
              unitLong: "teaspoons")
          )
        )
      ],
      id: 659463,
      title: "Savory Cheese Dill Scones",
      readyInMinutes: 45,
      servings: 12,
      summary: "Savory Cheese Dill Scones serves 12.",
      instructions: "Preheat oven to 375F.",
      analyzedInstructions: [
        AnalyzedInstruction(
          name: "",
          steps: [
            Step(
              number: 1,
              step: "Preheat oven to 375F.",
              ingredients: [],
              equipment: [
                Ent(
                  id: 404784,
                  name: "oven",
                  localizedName: "oven",
                  image: "oven.jpg"
                )
              ],
              length: nil)
          ])
      ]
    )
  ]

  func getRandomRecipe() async throws -> [Recipe] {
    return recipes
  }
}
