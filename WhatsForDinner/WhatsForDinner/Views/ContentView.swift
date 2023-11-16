//
//  ContentView.swift
//  WhatsForDinner
//
//  Created by John Phung on 11/12/23.
//

import SwiftUI

struct ContentView: View {
  @State private var searchResults = ""
  @StateObject private var randomRecipeVM = RandomRecipeViewModel()
  @StateObject private var searchRecipeVM = SearchRecipeViewModel()
  @EnvironmentObject var reviewRecipeVM: ReviewRecipeViewModel

  var body: some View {
    TabView {
      RecipeHomeView(randomRecipeVM: randomRecipeVM)
        .tabItem {
          Label("Home", systemImage: "house")
        }
      RecipeSearchView(
        searchResults: $searchResults,
        searchRecipeVM: searchRecipeVM
      )
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
    ContentView()
      .environmentObject(ReviewRecipeViewModel())
      .previewDevice(PreviewDevice(rawValue: "iPhone SE (2nd generation)"))
      .previewInterfaceOrientation(.landscapeLeft)
      .preferredColorScheme(.dark)
  }
}
