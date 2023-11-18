//
//  SearchRecipeViewModel.swift
//  WhatsForDinner
//
//  Created by John Phung on 11/14/23.
//

import Foundation

class SearchRecipeViewModel: ObservableObject {
  @Published var results: [Recipe] = []
  @Published var showAlert = false
  @Published var noResults = false
  @Published var isLoading = false
  @Published var showError = false
  @Published var error: Error?

  let service = RecipeService()

  @MainActor
  func fetchSearchResults(for query: String) async {
    isLoading = true
    do {
      if let searchResults = try await service.getSearchResults(for: query) {
        if searchResults.results.isEmpty {
          noResults = true
        } else {
          for result in searchResults.results {
            results.append(result)
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
}
