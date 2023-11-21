//
//  RecipeFavoritesView.swift
//  WhatsForDinner
//
//  Created by John Phung on 11/18/23.
//

import SwiftUI

struct RecipeFavoritesView: View {
  @EnvironmentObject var favoriteRecipeVM: FavoriteRecipeViewModel
  @State private var showDefaultScreen = true
  @State private var noResults = false
  @State private var favoriteSearch = ""

  var filteredSearch: [Favorite] {
    if favoriteSearch.isEmpty {
      return favoriteRecipeVM.favorite
    } else {
      return favoriteRecipeVM.favorite.filter { $0.title.lowercased().contains(favoriteSearch.lowercased()) }
    }
  }

  var body: some View {
    NavigationStack {
      List(filteredSearch, id: \.recipeId) { recipe in
        NavigationLink(value: recipe.recipe) {
          ListCellView(recipe: recipe.recipe)
            .swipeActions(allowsFullSwipe: false) {
              Button(role: .destructive) {
                deleteFavorites(for: recipe.recipeId)
              } label: {
                Label("Remove", systemImage: "trash")
              }
            }
        }
        .listRowSeparator(.hidden)
      }
      .navigationDestination(for: Recipe.self) { recipe in
        FavoriteDetailView(recipe: recipe)
      }
      .navigationTitle("Favorite Recipes")
      .searchable(text: $favoriteSearch, prompt: "Search your favorite recipe")
      .scrollIndicators(.hidden)
      .listStyle(.plain)
    }
    .overlay {
      if showDefaultScreen { DefaultFavoritesView() }
    }
  }

  private func deleteFavorites(for recipe: Int) {
    favoriteRecipeVM.removeFavorite(by: recipe)
  }
}

struct RecipeFavoritesView_Previews: PreviewProvider {
  static var previews: some View {
    RecipeFavoritesView()
      .environmentObject(ReviewRecipeViewModel())
      .environmentObject(FavoriteRecipeViewModel())
  }
}
