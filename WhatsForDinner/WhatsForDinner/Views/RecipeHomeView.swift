//
//  RecipeDetailView.swift
//  WhatsForDinner
//
//  Created by John Phung on 11/12/23.
//

import SwiftUI

struct RecipeHomeView: View {
  @ObservedObject var randomRecipeVM: RandomRecipeViewModel
  @ObservedObject var reviewRecipeVM: ReviewRecipeViewModel

  var body: some View {
    NavigationStack {
      List(randomRecipeVM.recipes) { recipe in
        NavigationLink(value: recipe) {
          ListCellView(recipe: recipe)
        }
        .listRowSeparator(.hidden)
      }
      .navigationDestination(for: Recipe.self) { recipe in
        RecipeDetailView(
          recipe: recipe,
          reviewRecipeVM: reviewRecipeVM
        )
      }
      .navigationTitle("What's For Dinner?")
      .scrollIndicators(.hidden)
      .listStyle(.plain)
    }
  }
}

struct RecipeHomeView_Previews: PreviewProvider {
  static var previews: some View {
    RecipeHomeView(
      randomRecipeVM: RandomRecipeViewModel(),
      reviewRecipeVM: ReviewRecipeViewModel()
    )
  }
}
