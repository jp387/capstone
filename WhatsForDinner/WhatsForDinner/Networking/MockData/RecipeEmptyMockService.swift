//
//  RecipeErrorMockService.swift
//  WhatsForDinner
//
//  Created by John Phung on 11/27/23.
//

import Foundation

struct RecipeEmptyMockService: RecipeServiceProtocol {
  var recipes: [Recipe] = []

  func getRandomRecipe() async throws -> [Recipe] {
    return recipes
  }

  func getSearchResults(for query: String) async throws -> [Recipe]? {
    return nil
  }
}
