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
      List {
      }
      .navigationTitle("Favorite Recipes")
    }
    .overlay {
      if favoriteRecipeVM.favorite.isEmpty { DefaultFavoritesView() }
    }
  }
}

struct RecipeFavoritesView_Previews: PreviewProvider {
  static var previews: some View {
    RecipeFavoritesView()
      .environmentObject(ReviewRecipeViewModel())
      .environmentObject(FavoriteRecipeViewModel())
  }
}
