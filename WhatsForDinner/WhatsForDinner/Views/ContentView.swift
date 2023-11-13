//
//  ContentView.swift
//  WhatsForDinner
//
//  Created by John Phung on 11/12/23.
//

import SwiftUI

struct ContentView: View {
  @StateObject private var randomRecipeVM = RandomRecipeViewModel()

  var body: some View {
    TabView {
      RecipeHomeView(randomRecipeVM: randomRecipeVM)
        .tabItem {
          Label("Home", systemImage: "house")
        }
    }
//    .task {
//      await randomRecipeVM.fetchRandomRecipe()
//    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
    ContentView()
      .previewDevice(PreviewDevice(rawValue: "iPhone SE (2nd generation)"))
      .previewInterfaceOrientation(.landscapeLeft)
      .preferredColorScheme(.dark)
  }
}
