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
    NavigationStack {
      List(randomRecipeVM.recipes) { recipe in
        NavigationLink(value: recipe) {
          HStack {
            AsyncImage(url: URL(string: "https://spoonacular.com/recipeImages/\(recipe.id)-90x90.jpg")) { image in
              image
            } placeholder: {
              ProgressView()
            }
            .frame(width: 90, height: 90)
            .background(.gray)
            VStack(alignment: .leading) {
              Text(recipe.title)
              Text("Cooking Time: \(recipe.readyInMinutes) minutes")
                .font(.caption)
              Text("Serving: \(recipe.servings)")
                .font(.caption)
            }
          }
        }
      }
      .navigationTitle("What's For Dinner?")
      .scrollIndicators(.hidden)
      .listStyle(.plain)
    }
//    .task {
//      await randomRecipeVM.fetchRandomRecipe()
//    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
