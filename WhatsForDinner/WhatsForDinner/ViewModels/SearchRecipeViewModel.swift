//
//  SearchRecipeViewModel.swift
//  WhatsForDinner
//
//  Created by John Phung on 11/14/23.
//

import Foundation

class SearchRecipeViewModel: ObservableObject {
  @Published var results: [Recipe] = []

  let service = RecipeService()

  @MainActor
  func fetchSearchResults(for query: String) async {
    do {
      if let searchResults = try await service.getSearchResults(for: query) {
        for result in searchResults.results {
          results.append(result)
        }
      }
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
