//
//  RecipeDetailView.swift
//  WhatsForDinner
//
//  Created by John Phung on 11/12/23.
//

import SwiftUI

struct RecipeHomeView: View {
  @ObservedObject var randomRecipeVM: RandomRecipeViewModel

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
              if recipe.readyInMinutes > 60 {
                let hours = Int(recipe.readyInMinutes / 60)
                let minutes = Int(recipe.readyInMinutes - (hours * 60))
                let hoursText = hours > 1 ? "hours" : "hour"
                Text("Cooking Time: \(hours) \(hoursText) \(minutes) minutes")
                  .font(.caption)
              } else {
                Text("Cooking Time: \(recipe.readyInMinutes) minutes")
                  .font(.caption)
              }
              Text("Serving: \(recipe.servings)")
                .font(.caption)
            }
          }
        }
      }
      .navigationDestination(for: Recipe.self, destination: { recipe in
        RecipeDetailView(recipe: recipe)
      })
      .navigationTitle("What's For Dinner?")
      .scrollIndicators(.hidden)
      .listStyle(.plain)
    }
  }
}

struct RecipeHomeView_Previews: PreviewProvider {
  static var previews: some View {
    RecipeHomeView(randomRecipeVM: RandomRecipeViewModel())
  }
}
