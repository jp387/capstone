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
  @State private var networkFailure = false

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
          networkFailure = true
        }
      }
      .alert(errorMessage, isPresented: $randomRecipeVM.showError) {
        Button("OK") {
          networkFailure = true
        }
      }
      .navigationTitle("What's For Dinner?")
      .navigationBarItems(
        trailing:
          RefreshButtonView(randomRecipeVM: randomRecipeVM)
      )
      .scrollIndicators(.hidden)
      .listStyle(.plain)
      .task {
        if randomRecipeVM.recipes.isEmpty {
          randomRecipeVM.fetchBundleRecipe()
          //  await randomRecipeVM.fetchRandomRecipe()
          //  networkFailure = false
        }
      }
    }
    .overlay {
      if networkFailure { NoRecipesView() }
      if randomRecipeVM.isLoading { ProgressView() }
    }
  }
}

struct RefreshButtonView: View {
  @ObservedObject var randomRecipeVM: RandomRecipeViewModel

  var body: some View {
    Button {
      Task {
        await randomRecipeVM.refreshRandomRecipe()
      }
    } label: {
      Image(systemName: "arrow.clockwise")
    }
    .disabled(randomRecipeVM.isBundle)
  }
}

struct RecipeHomeView_Previews: PreviewProvider {
  static var previews: some View {
    RecipeHomeView(randomRecipeVM: RandomRecipeViewModel())
      .environmentObject(ReviewRecipeViewModel())
  }
}
