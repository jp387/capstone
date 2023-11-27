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

  let service: RecipeServiceProtocol

  init(service: RecipeServiceProtocol) {
    self.service = service
  }

  @MainActor
  func fetchRandomRecipe() async throws {
    isLoading = true
    do {
      let results = try await service.getRandomRecipe()
      if results.isEmpty {
        showAlert = true
      } else {
        for item in results {
          recipes.append(item)
        }
      }
    } catch {
      self.error = error
      showError = true
    }
    isLoading = false
  }

  @MainActor
  func refreshRandomRecipe() async throws {
    recipes.removeAll()
    try await fetchRandomRecipe()
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
