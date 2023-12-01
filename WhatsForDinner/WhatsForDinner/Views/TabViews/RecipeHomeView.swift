//
//  RecipeHomeView.swift
//  WhatsForDinner
//
//  Created by John Phung on 11/12/23.
//

import SwiftUI

struct RecipeHomeView: View {
  @StateObject var randomRecipeVM = RandomRecipeViewModel(service: RecipeService())
  @EnvironmentObject var reviewRecipeVM: ReviewRecipeViewModel

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
      .alert("Unable to fetch your dinner list. Try again later!", isPresented: $randomRecipeVM.showAlertPrompt) {
        Button("OK") {
          randomRecipeVM.showFailureScreen = true
        }
        .accessibilityIdentifier("list-failure-prompt")
      }
      .alert(randomRecipeVM.errorMessage, isPresented: $randomRecipeVM.showError) {
        Button("OK") {
          randomRecipeVM.showFailureScreen = true
        }
        .accessibilityIdentifier("network-failure-prompt")
      }
      .navigationTitle("Dinner Recipes")
      .toolbar {
        RefreshButtonView(randomRecipeVM: randomRecipeVM)
      }
      .toolbarBackground(.yellow, for: .navigationBar)
      .toolbarBackground(.visible, for: .navigationBar)
      .listStyle(.plain)
      // .onAppear {
      //  if randomRecipeVM.recipes.isEmpty {
      //    randomRecipeVM.fetchBundleRecipe(for: "recipestub")
      //  }
      // }
      .task {
        if randomRecipeVM.recipes.isEmpty {
          do {
            try await randomRecipeVM.fetchRandomRecipe()
          } catch { }
        }
      }
      .overlay {
        if randomRecipeVM.showFailureScreen {
          NoRecipesView()
        }
        if randomRecipeVM.isLoading {
          LoadingProgressView()
        }
      }
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
        .rotationEffect(.degrees(
          isSpinning ? Constants.HomeView.rotationEffectDefault : Constants.HomeView.rotationEffectFullCircle))
        .animation(.easeInOut(
          duration: Constants.General.animationDuration), value: isSpinning)
    }
    .accessibilityIdentifier("refresh-button")
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
