//
//  ContentView.swift
//  WhatsForDinner
//
//  Created by John Phung on 11/12/23.
//

import SwiftUI

struct MainView: View {
  var body: some View {
    TabView {
      RecipeHomeView()
        .tabItem {
          Label("Home", systemImage: "house")
        }
      RecipeFavoritesView()
        .tabItem {
          Label("Favorites", systemImage: "heart")
        }
      RecipeSearchView()
      .tabItem {
        Label("Search", systemImage: "magnifyingglass")
      }
    }
  }
}

struct MainView_Previews: PreviewProvider {
  static var previews: some View {
    MainView()
      .environmentObject(ReviewRecipeViewModel())
      .environmentObject(FavoriteRecipeViewModel())
    MainView()
      .environmentObject(ReviewRecipeViewModel())
      .environmentObject(FavoriteRecipeViewModel())
      .previewDevice(PreviewDevice(rawValue: "iPhone SE (2nd generation)"))
      .previewInterfaceOrientation(.landscapeLeft)
      .preferredColorScheme(.dark)
    MainView()
      .environmentObject(ReviewRecipeViewModel())
      .environmentObject(FavoriteRecipeViewModel())
      .previewDevice(PreviewDevice(rawValue: "iPhone SE (2nd generation)"))
  }
}
