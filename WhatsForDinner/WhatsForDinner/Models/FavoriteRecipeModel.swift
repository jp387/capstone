//
//  FavoriteRecipeModel.swift
//  WhatsForDinner
//
//  Created by John Phung on 11/18/23.
//

import Foundation

struct Favorites: Codable {
  var favorites: [Favorite]
}

struct Favorite: Codable, Hashable, Identifiable {
  let id: UUID
  let recipeId: Int
  let favorited: Bool
  let date: String
}
