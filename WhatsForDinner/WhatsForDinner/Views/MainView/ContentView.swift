//
//  ContentView.swift
//  WhatsForDinner
//
//  Created by John Phung on 11/12/23.
//

import SwiftUI

struct ContentView: View {
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

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
      .environmentObject(ReviewRecipeViewModel())
      .environmentObject(FavoriteRecipeViewModel())
    ContentView()
      .environmentObject(ReviewRecipeViewModel())
      .environmentObject(FavoriteRecipeViewModel())
      .previewDevice(PreviewDevice(rawValue: "iPhone SE (2nd generation)"))
      .previewInterfaceOrientation(.landscapeLeft)
      .preferredColorScheme(.dark)
    ContentView()
      .environmentObject(ReviewRecipeViewModel())
      .environmentObject(FavoriteRecipeViewModel())
      .previewDevice(PreviewDevice(rawValue: "iPhone SE (2nd generation)"))
  }
}
