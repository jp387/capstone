//
//  RandomRecipeViewModel.swift
//  LastMinuteMeals
//
//  Created by John Phung on 11/12/23.
//

import Foundation

class RandomRecipeViewModel: ObservableObject {
  @Published var recipes: [Recipe] = []
  @Published var results: Recipes?

  let service = RandomRecipeService()

  init() {
    fetchBundleRecipe()
  }

  @MainActor
  func fetchRandomRecipe() async throws {
    if let results = try await service.getRandomRecipe() {
      for item in results.recipes {
        recipes.append(item)
      }
    }
  }

  func fetchBundleRecipe() {
    guard let recipeURL =
      Bundle.main.url(forResource: "recipestub", withExtension: "json") else {
      return
    }

    let decoder = JSONDecoder()

    do {
      let recipeData = try Data(contentsOf: recipeURL)
      results = try decoder.decode(Recipes.self, from: recipeData)
      guard let results = results else { return }
      recipes = results.recipes
    } catch DecodingError.dataCorrupted(let context) {
      print("Data corrupted: \(context.debugDescription)")
    } catch DecodingError.keyNotFound(let key, let context) {
      print("Key '\(key.stringValue)' not found: \(context.debugDescription)")
    } catch DecodingError.typeMismatch(let type, let context) {
      print("Type mismatch for type \(type): \(context.debugDescription)")
    } catch DecodingError.valueNotFound(let type, let context) {
      print("Value not found for type \(type): \(context.debugDescription)")
    } catch {
      print("Other decoding error: \(error)")
    }
  }
}
