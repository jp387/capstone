//
//  WhatsForDinnerTests.swift
//  WhatsForDinnerTests
//
//  Created by John Phung on 11/12/23.
//

import XCTest
@testable import WhatsForDinner

final class RandomRecipesViewModelTests: XCTestCase {
  // swiftlint:disable implicitly_unwrapped_optional
  var randomRecipeVM: RandomRecipeViewModel!
  // swiftlint:enable implicitly_unwrapped_optional

  override func setUp() {
    randomRecipeVM = RandomRecipeViewModel(service: RecipeMockService())
  }

  func test_randomRecipeLoadsCorrectData() async throws {
    XCTAssertFalse(randomRecipeVM.isLoading)
    XCTAssertEqual(randomRecipeVM.recipes, [])
    XCTAssertNil(randomRecipeVM.error)

    try await randomRecipeVM.fetchRandomRecipe()

    XCTAssertFalse(randomRecipeVM.isLoading)
    XCTAssertEqual(randomRecipeVM.recipes, [
      Recipe(
        pricePerServing: 141.03,
        extendedIngredients: [
          ExtendedIngredient(
            id: Optional(1145),
            aisle: Optional("Milk, Eggs, Other Dairy"),
            consistency: Optional(Consistency.solid),
            name: Optional("butter"),
            original: Optional("2 tablespoons butter"),
            originalName: Optional("unsalted butter"),
            amount: Optional(Double(2)),
            unit: Optional("tablespoons"),
            meta: Optional([
              "unsalted",
              "melted"
            ]),
            measures: Optional(Measures(
              usa: Metric(
                amount: Double(2),
                unitShort: "Tbsps",
                unitLong: "Tbsps"),
              metric: Metric(
                amount: Double(2),
                unitShort: "Tbsps",
                unitLong: "Tbsps")
            ))
          )
        ],
        id: 633265,
        title: "Bacon & Egg Toast Cups",
        readyInMinutes: 45,
        servings: 2,
        summary: "Bacon & Egg Toast Cups takes 45 minutes.",
        instructions: Optional("Preheat oven to 375."),
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
            id: Optional(18369),
            aisle: Optional("Baking"),
            consistency: Optional(Consistency.solid),
            name: Optional("baking powder"),
            original: Optional("3/4 teaspoon baking powder"),
            originalName: Optional("baking powder"),
            amount: Optional(0.75),
            unit: Optional("teaspoon"),
            meta: Optional([]),
            measures: Optional(Measures(
              usa: Metric(
                amount: 0.75,
                unitShort: "tsps",
                unitLong: "teaspoons"),
              metric: Metric(
                amount: 0.75,
                unitShort: "tsps",
                unitLong: "teaspoons")
            )
          ))
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
    ])
    XCTAssertNil(randomRecipeVM.error)
  }
}
