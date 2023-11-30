//
//  SearchRecipeViewModel.swift
//  WhatsForDinner
//
//  Created by John Phung on 11/14/23.
//

import Foundation

class SearchRecipeViewModel: ObservableObject {
  @Published var results: [Recipe] = []
  @Published var showAlertPrompt = false
  @Published var noResults = false
  @Published var isLoading = false
  @Published var showErrorPrompt = false
  @Published var searchResults = ""
  @Published var showDefaultScreen = true
  @Published var showNoNetworkScreen = false
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
  func fetchSearchResults(for query: String) async {
    isLoading = true
    do {
      if let searchResults = try await service.getSearchResults(for: query) {
        if searchResults.isEmpty {
          noResults = true
        } else {
          for result in searchResults {
            results.append(result)
          }
        }
      } else {
        showAlertPrompt = true
      }
    } catch {
      self.error = error
      showErrorPrompt = true
    }
    isLoading = false
  }
}
