//
//  RecipeHomeView.swift
//  WhatsForDinner
//
//  Created by John Phung on 11/12/23.
//

import SwiftUI

struct RecipeHomeView: View {
  @ObservedObject var randomRecipeVM: RandomRecipeViewModel
  @EnvironmentObject var reviewRecipeVM: ReviewRecipeViewModel
  @State private var showFailure = false

  var errorMessage: String {
    if let error = randomRecipeVM.error {
      return error.localizedDescription
    }
    return ""
  }

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
      .alert("Unable to fetch your dinner list. Try again later!", isPresented: $randomRecipeVM.showAlert) {
        Button("OK") {
          showFailure = true
        }
      }
      .alert(errorMessage, isPresented: $randomRecipeVM.showError) {
        Button("OK") {
          showFailure = true
        }
      }
      .navigationTitle("What's For Dinner?")
      .scrollIndicators(.hidden)
      .listStyle(.plain)
      .task {
        if randomRecipeVM.recipes.isEmpty {
          randomRecipeVM.fetchBundleRecipe()
          //  await randomRecipeVM.fetchRandomRecipe()
          //  showFailure = false
        }
      }
    }
    .overlay {
      if showFailure { NoRecipesView() }
      if randomRecipeVM.isLoading { ProgressView() }
    }
  }
}

struct RecipeHomeView_Previews: PreviewProvider {
  static var previews: some View {
    RecipeHomeView(randomRecipeVM: RandomRecipeViewModel())
      .environmentObject(ReviewRecipeViewModel())
  }
}
