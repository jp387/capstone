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
          RecipeCardView(recipe: recipe)
        }
        .listRowSeparator(.hidden)
      }
      .accessibilityIdentifier("recipe-list")
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
      .navigationTitle("Dinner Recipes")
      .toolbar {
        RefreshButtonView(randomRecipeVM: randomRecipeVM)
      }
      .toolbarBackground(.yellow, for: .navigationBar)
      .toolbarBackground(.visible, for: .navigationBar)
      .scrollIndicators(.hidden)
      .listStyle(.plain)
      .task {
        if randomRecipeVM.recipes.isEmpty {
          randomRecipeVM.fetchBundleRecipe(for: "recipestub")
          //  do {
          //    try await randomRecipeVM.fetchRandomRecipe()
          //    networkFailure = false
          //  } catch { }
        }
      }
    }
    .overlay {
      if networkFailure { NoRecipesView() }
      if randomRecipeVM.isLoading { LoadingProgressView() }
    }
  }
}

struct RefreshButtonView: View {
  @ObservedObject var randomRecipeVM: RandomRecipeViewModel
  @State private var isSpinning = false

  var body: some View {
    Button {
      Task {
        try await randomRecipeVM.refreshRandomRecipe()
      }
      isSpinning.toggle()
    } label: {
      Image(systemName: "arrow.clockwise")
        .rotationEffect(.degrees(isSpinning ? 0 : 360))
        .animation(.easeInOut(duration: 1), value: isSpinning)
    }
    .foregroundColor(.red)
    .disabled(randomRecipeVM.isBundle)
  }
}

struct RecipeHomeView_Previews: PreviewProvider {
  static var previews: some View {
    RecipeHomeView(randomRecipeVM: RandomRecipeViewModel(service: RecipeService()))
      .environmentObject(ReviewRecipeViewModel())
      .environmentObject(FavoriteRecipeViewModel())
  }
}
