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
      .toolbarBackground(.red, for: .navigationBar)
      .toolbarBackground(.visible, for: .navigationBar)
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
        await randomRecipeVM.refreshRandomRecipe()
      }
      isSpinning.toggle()
    } label: {
      Image(systemName: "arrow.clockwise")
        .rotationEffect(.degrees(isSpinning ? 0 : 360))
        .animation(.easeInOut(duration: 1), value: isSpinning)
    }
    .foregroundColor(.yellow)
    .disabled(randomRecipeVM.isBundle)
  }
}

struct RecipeHomeView_Previews: PreviewProvider {
  static var previews: some View {
    RecipeHomeView(randomRecipeVM: RandomRecipeViewModel())
      .environmentObject(ReviewRecipeViewModel())
      .environmentObject(FavoriteRecipeViewModel())
  }
}
