//
//  RecipeDetailView.swift
//  WhatsForDinner
//
//  Created by John Phung on 11/12/23.
//

import SwiftUI

struct RecipeHomeView: View {
  @ObservedObject var randomRecipeVM: RandomRecipeViewModel
  @EnvironmentObject var reviewRecipeVM: ReviewRecipeViewModel

  var body: some View {
    NavigationStack {
      List(randomRecipeVM.recipes) { recipe in
        NavigationLink(value: recipe) {
          ListCellView(recipe: recipe)
        }
        .listRowSeparator(.hidden)
      }
      .navigationDestination(for: Recipe.self) { recipe in
        RecipeDetailView(recipe: recipe)
      }
      .alert("Unable to fetch your dinner list. Try again later!", isPresented: $randomRecipeVM.showAlert) { }
      .navigationTitle("What's For Dinner?")
      .scrollIndicators(.hidden)
      .listStyle(.plain)
      .task {
        if randomRecipeVM.recipes.isEmpty {
//          await randomRecipeVM.fetchRandomRecipe()
          randomRecipeVM.fetchBundleRecipe()
        }
      }
    }
  }
}

struct RecipeHomeView_Previews: PreviewProvider {
  static var previews: some View {
    RecipeHomeView(randomRecipeVM: RandomRecipeViewModel())
      .environmentObject(ReviewRecipeViewModel())
  }
}
