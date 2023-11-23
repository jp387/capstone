//
//  RandomRecipeViewModel.swift
//  WhatsForDinner
//
//  Created by John Phung on 11/12/23.
//

import Foundation

class RandomRecipeViewModel: ObservableObject {
  @Published var recipes: [Recipe] = []
  @Published var showAlert = false
  @Published var showError = false
  @Published var isLoading = false
  @Published var isBundle = false
  @Published var error: Error?

  let service = RecipeService()

  @MainActor
  func fetchRandomRecipe() async {
    isLoading = true
    do {
      if let results = try await service.getRandomRecipe(numberOfRecipes: 1) {
        if results.recipes.isEmpty {
          showAlert = true
        } else {
          for item in results.recipes {
            recipes.append(item)
          }
        }
      } else {
        showAlert = true
      }
    } catch {
      self.error = error
      showError = true
    }
    isLoading = false
  }

  @MainActor
  func refreshRandomRecipe() async {
    recipes.removeAll()
    await fetchRandomRecipe()
  }

  func fetchBundleRecipe() {
    isLoading = true
    isBundle = true
    let decoder = JSONDecoder()

    if let recipeURL =
      Bundle.main.url(forResource: "recipestub", withExtension: "json") {
      do {
        let recipeData = try Data(contentsOf: recipeURL)
        recipes = try decoder.decode(Recipes.self, from: recipeData).recipes
        if recipes.isEmpty {
          showAlert = true
        }
      } catch {
        self.error = error
        showAlert = true
      }
    } else {
      showAlert = true
    }
    isLoading = false
  }
}
