//
//  RecipeFavoritesView.swift
//  WhatsForDinner
//
//  Created by John Phung on 11/18/23.
//

import SwiftUI

struct RecipeFavoritesView: View {
  @EnvironmentObject var favoriteRecipeVM: FavoriteRecipeViewModel
  @State private var searchFailed = false
  @State private var favoriteSearch = ""

  var filteredFavorites: [Favorite] {
    if favoriteSearch.isEmpty {
      return favoriteRecipeVM.favorite
    } else {
      return favoriteRecipeVM.favorite.filter { $0.title.lowercased().contains(favoriteSearch.lowercased()) }
    }
  }

  var body: some View {
    NavigationStack {
      List(filteredFavorites, id: \.recipeId) { recipe in
        NavigationLink(value: recipe.recipe) {
          RecipeCardView(recipe: recipe.recipe)
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
      .toolbarBackground(.yellow, for: .navigationBar)
      .toolbarBackground(.visible, for: .navigationBar)
      .navigationDestination(for: Recipe.self) { recipe in
        FavoriteDetailView(recipe: recipe)
      }
      .navigationTitle("Favorited Recipes")
      .searchable(text: $favoriteSearch, prompt: "Search for your favorited recipes")
      .listStyle(.plain)
    }
    .overlay {
      if favoriteRecipeVM.favorite.isEmpty, favoriteSearch.isEmpty { DefaultFavoritesView() }
      if filteredFavorites.isEmpty, !favoriteSearch.isEmpty { NoResultsView() }
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
