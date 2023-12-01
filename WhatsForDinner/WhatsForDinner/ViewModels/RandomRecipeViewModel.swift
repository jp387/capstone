//
//  RandomRecipeViewModel.swift
//  WhatsForDinner
//
//  Created by John Phung on 11/12/23.
//

import Foundation

class RandomRecipeViewModel: ObservableObject {
  @Published var recipes: [Recipe] = []
  @Published var showAlertPrompt = false
  @Published var showError = false
  @Published var isLoading = false
  @Published var isBundle = false
  @Published var showFailureScreen = false
  @Published var error: Error?

  let service: RecipeServiceProtocol

  init(service: RecipeServiceProtocol) {
    self.service = service
  }

  var errorMessage: String {
    if let error = error {
      return error.localizedDescription
    }
    return ""
  }

  @MainActor
  func fetchRandomRecipe() async throws {
    isLoading = true
    do {
      let results = try await service.getRandomRecipe()
      if results.isEmpty {
        showAlertPrompt = true
      } else {
        recipes = results
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

  func fetchBundleRecipe(for bundle: String) {
    isLoading = true
    isBundle = true
    let decoder = JSONDecoder()

    if let recipeURL =
      Bundle.main.url(forResource: "\(bundle)", withExtension: "json") {
      do {
        let recipeData = try Data(contentsOf: recipeURL)
        recipes = try decoder.decode(Recipes.self, from: recipeData).recipes
        if recipes.isEmpty {
          showAlertPrompt = true
        }
      } catch {
        self.error = error
        showAlertPrompt = true
      }
    } else {
      showAlertPrompt = true
    }
    isLoading = false
  }
}
