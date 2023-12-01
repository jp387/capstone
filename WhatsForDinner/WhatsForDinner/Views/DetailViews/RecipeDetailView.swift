//
//  RecipeDetailView.swift
//  WhatsForDinner
//
//  Created by John Phung on 11/12/23.
//

import SwiftUI

struct RecipeDetailView: View {
  var recipe: Recipe
  @EnvironmentObject var reviewRecipeVM: ReviewRecipeViewModel
  @EnvironmentObject var favoriteRecipeVM: FavoriteRecipeViewModel

  var body: some View {
    ScrollView(showsIndicators: false) {
      VStack {
        RecipeHeaderView(recipe: recipe)
        RecipeInformationView(recipe: recipe)
        Divider()
        RecipeSummaryView(recipe: recipe)
        Divider()
        RecipeIngredientsView(recipe: recipe)
        Divider()
        RecipeInstructionsView(recipe: recipe)
        Divider()
        RecipeReviewsView(recipe: recipe)
      }
    }
    .navigationBarTitleDisplayMode(.inline)
    .accessibilityIdentifier("recipe-details")
  }
}

struct RecipeHeaderView: View {
  var recipe: Recipe

  var body: some View {
    VStack {
      Text(recipe.title)
        .font(.headline)
        .frame(width: Constants.RecipeDetail.detailFrameWidth)
      ZStack {
        AsyncImage(url: recipe.fullImageURL) { image in
          image
        } placeholder: {
          ProgressView()
            .tint(.red)
            .controlSize(.large)
        }
        .frame(
          width: Constants.RecipeDetail.headerImageWidth,
          height: Constants.RecipeDetail.headerImageHeight)
        .background(.gray)
        FavoriteButtonView(recipe: recipe)
          .accessibilityIdentifier("favorite-button")
      }
    }
    .accessibilityIdentifier("recipe-header")
  }
}

struct RecipeInformationView: View {
  var recipe: Recipe

  var body: some View {
    HStack {
      VStack {
        Image("cheap")
        Text("$\(String(format: "%.2f", recipe.pricePerServingCost)) per serving")
          .font(.subheadline)
      }
      .padding()
      VStack {
        Image("fast")
        recipe.cookingTime
      }
      .padding()
    }
    .accessibilityIdentifier("recipe-data")
  }
}

struct RecipeSummaryView: View {
  var recipe: Recipe
  @EnvironmentObject var reviewRecipeVM: ReviewRecipeViewModel

  var body: some View {
    VStack {
      Text("Summary")
        .padding()
      Text(recipe.summary.stripHTML)
        .frame(width: Constants.RecipeDetail.detailFrameWidth)
      ReviewButtonView(recipeId: recipe.id)
        .accessibilityIdentifier("recipe-detail-review-button")
    }
    .accessibilityIdentifier("recipe-summary")
  }
}

struct RecipeIngredientsView: View {
  var recipe: Recipe

  var body: some View {
    Text("Ingredients")
      .padding()
    VStack(alignment: .leading) {
      ForEach(recipe.extendedIngredients, id: \.id) { ingredient in
        Text("* \(ingredient.original ?? "")")
      }
    }
    .frame(width: Constants.RecipeDetail.detailFrameWidth)
    .accessibilityIdentifier("recipe-ingredients")
  }
}

struct RecipeInstructionsView: View {
  var recipe: Recipe

  var body: some View {
    Text("Cooking Instructions")
      .padding()
    VStack(alignment: .leading) {
      if let instructions = recipe.analyzedInstructions.first {
        ForEach(instructions.steps, id: \.number) { instruction in
          Text("\(String(instruction.number)). \(instruction.step)")
        }
      }
    }
    .frame(width: Constants.RecipeDetail.detailFrameWidth)
    .accessibilityIdentifier("recipe-instructions")
  }
}

struct RecipeReviewsView: View {
  var recipe: Recipe
  @EnvironmentObject var reviewRecipeVM: ReviewRecipeViewModel

  var filteredReviews: [Review] {
    return reviewRecipeVM.review.filter { $0.recipeId == recipe.id }
  }

  var body: some View {
    Text("Reviews")
      .padding()
    VStack(alignment: .leading) {
      ForEach(filteredReviews) { review in
        Text("Posted on \(review.date)")
        Text("Rating: \(String(review.rating))")
          .padding(.bottom, Constants.RecipeDetail.reviewPadding)
        Text("Comment: \(review.comment)")
        Divider()
      }
    }
    .frame(width: Constants.RecipeDetail.detailFrameWidth)
    .overlay {
      if filteredReviews.isEmpty { Text("No reviews for this recipe.") }
    }
    .padding(Constants.RecipeDetail.reviewPadding)
    .accessibilityIdentifier("recipe-reviews")
  }
}

struct FavoriteButtonView: View {
  var recipe: Recipe
  @EnvironmentObject var favoriteRecipeVM: FavoriteRecipeViewModel

  var favoriteRecipeExist: Bool {
    return favoriteRecipeVM.containsFavorite(for: recipe.id)
  }

  var body: some View {
    Button {
      if favoriteRecipeExist {
        deleteFavorites()
      } else {
        addFavorites()
      }
    } label: {
      Image(systemName: favoriteRecipeExist ? "heart.fill" : "heart")
        .font(.largeTitle)
        .foregroundColor(.red)
    }
  }

  private func addFavorites() {
    favoriteRecipeVM.addFavorite(recipeId: recipe.id, title: recipe.title, recipe: recipe)
  }

  private func deleteFavorites() {
    favoriteRecipeVM.removeFavorite(by: recipe.id)
  }
}
