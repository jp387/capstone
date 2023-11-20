//
//  RecipeFavoritesView.swift
//  WhatsForDinner
//
//  Created by John Phung on 11/18/23.
//

import SwiftUI

struct RecipeFavoritesView: View {
  @EnvironmentObject var favoriteRecipeVM: FavoriteRecipeViewModel

  var body: some View {
    NavigationStack {
      List(favoriteRecipeVM.favorite, id: \.recipeId) { recipe in
        NavigationLink(value: recipe.recipe) {
          ListCellView(recipe: recipe.recipe)
            .swipeActions(allowsFullSwipe: false) {
              Button(role: .destructive) {
                deleteFavorites(for: recipe.recipeId)
              } label: {
                Label("Remove", systemImage: "heart")
              }
            }
        }
        .listRowSeparator(.hidden)
      }
      .navigationDestination(for: Recipe.self) { recipe in
        FavoriteDetailView(recipe: recipe)
      }
      .navigationTitle("Favorite Recipes")
      .scrollIndicators(.hidden)
      .listStyle(.plain)
    }
    .overlay {
      if favoriteRecipeVM.favorite.isEmpty { DefaultFavoritesView() }
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
