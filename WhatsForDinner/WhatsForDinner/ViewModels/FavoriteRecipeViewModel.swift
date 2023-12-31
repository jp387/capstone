//
//  FavoriteRecipeViewModel.swift
//  WhatsForDinner
//
//  Created by John Phung on 11/18/23.
//

import Foundation

class FavoriteRecipeViewModel: ObservableObject {
  @Published var favorite: [Favorite] = [] {
    didSet {
      saveFavorites()
    }
  }

  let favoriteURL = URL(
    filePath: "favorites",
    relativeTo: FileManager.documentDirectoryURL
  ).appendingPathExtension("json")

  init() {
    loadFavorites()
  }

  private func loadFavorites() {
    let decoder = JSONDecoder()

    do {
      let data = try Data(contentsOf: favoriteURL)
      favorite = try decoder.decode(Favorites.self, from: data).favorites
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

  func containsFavorite(for recipeId: Int) -> Bool {
    return favorite.contains { recipe in
      recipe.recipeId == recipeId
    }
  }

  func addFavorite(
    id: UUID = UUID(),
    recipeId: Int,
    favorited: Bool = true,
    date: String = Date().description,
    title: String,
    recipe: Recipe
  ) {
    let newFavorite = Favorite(
      id: id,
      recipeId: recipeId,
      favorited: favorited,
      date: date,
      title: title,
      recipe: recipe)
    favorite.append(newFavorite)
  }

  func removeFavorite(by recipeId: Int) {
    let index = favorite.firstIndex { $0.recipeId == recipeId }
    guard let index else { return }
    favorite.remove(at: index)
  }

  private func saveFavorites() {
    let encoder = JSONEncoder()
    encoder.outputFormatting = [.prettyPrinted, .withoutEscapingSlashes, .sortedKeys]

    let reviewsData = Favorites(favorites: favorite)

    do {
      let data = try encoder.encode(reviewsData)
      try data.write(to: favoriteURL, options: .atomicWrite)
    } catch {
      print("Unable to encode favorites due to the following error: \(error.localizedDescription)")
    }
  }
}
