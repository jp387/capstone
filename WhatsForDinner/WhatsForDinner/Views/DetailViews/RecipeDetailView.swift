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
        .frame(width: 350)
      ZStack {
        AsyncImage(url: URL(string: "https://spoonacular.com/recipeImages/\(recipe.id)-480x360.jpg")) { image in
          image
        } placeholder: {
          ProgressView()
            .tint(.red)
            .controlSize(.large)
        }
        .frame(width: 480, height: 360)
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

  var pricePerServing: Double {
    return Double(recipe.pricePerServing / 100.0)
  }

  var hours: Int {
    return Int(recipe.readyInMinutes / 60)
  }

  var minutes: Int {
    return Int(recipe.readyInMinutes - (hours * 60))
  }

  var body: some View {
    HStack {
      VStack {
        Image("cheap")
        Text("$\(String(format: "%.2f", pricePerServing)) per serving")
          .font(.subheadline)
      }
      .padding()
      VStack {
        Image("fast")
        if recipe.readyInMinutes >= 60 {
          let hoursText = hours > 1 ? "hours" : "hour"

          if minutes == 0 || minutes == 60 {
            Text("Ready in \(hours) \(hoursText)")
              .font(.subheadline)
          } else if minutes == 1 {
            Text("Ready in \(hours) \(hoursText) \(minutes) minute")
              .font(.subheadline)
          } else {
            Text("Ready in \(hours) \(hoursText) \(minutes) minutes")
              .font(.subheadline)
          }
        } else {
          Text("Ready in \(recipe.readyInMinutes) minutes")
            .font(.subheadline)
        }
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
        .frame(width: 350)
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
    .frame(width: 350)
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
    .frame(width: 350)
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
          .padding(.bottom, 5)
        Text("Comment: \(review.comment)")
        Divider()
      }
    }
    .frame(width: 350)
    .overlay {
      if filteredReviews.isEmpty { Text("No reviews for this recipe.") }
    }
    .padding(5)
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
      if !favoriteRecipeExist {
        addFavorites()
      } else {
        deleteFavorites()
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
