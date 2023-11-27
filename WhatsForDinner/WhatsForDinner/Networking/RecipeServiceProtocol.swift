//
//  RecipeServiceProtocol.swift
//  WhatsForDinner
//
//  Created by John Phung on 11/26/23.
//

import Foundation

protocol RecipeServiceProtocol {
  func getRandomRecipe() async throws -> [Recipe]
}
