//
//  FavoriteDetailView.swift
//  WhatsForDinner
//
//  Created by John Phung on 11/19/23.
//

import SwiftUI

struct FavoriteDetailView: View {
  var recipe: Recipe
  @EnvironmentObject var reviewRecipeVM: ReviewRecipeViewModel
  @EnvironmentObject var favoriteRecipeVM: FavoriteRecipeViewModel

  var body: some View {
    ScrollView(showsIndicators: false) {
      VStack {
        FavoriteHeaderView(recipe: recipe)
        FavoriteDataView(recipe: recipe)
        Divider()
        FavoriteSummaryView(recipe: recipe)
        Divider()
        FavoriteIngredientsView(recipe: recipe)
        Divider()
        FavoriteInstructionsView(recipe: recipe)
        Divider()
        FavoriteReviewsView(recipe: recipe)
      }
    }
    .navigationBarTitleDisplayMode(.inline)
  }
}

struct FavoriteHeaderView: View {
  var recipe: Recipe

  var body: some View {
    VStack {
      Text(recipe.title)
        .font(.headline)
        .frame(width: Constants.RecipeDetail.detailFrameWidth)
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
    }
    .accessibilityIdentifier("favorite-recipe-header")
  }
}

struct FavoriteDataView: View {
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
    .accessibilityIdentifier("favorite-recipe-data")
  }
}

struct FavoriteSummaryView: View {
  var recipe: Recipe
  @EnvironmentObject var reviewRecipeVM: ReviewRecipeViewModel

  var body: some View {
    VStack {
      Text("Summary")
        .padding()
      Text(recipe.summary.stripHTML)
        .frame(width: Constants.RecipeDetail.detailFrameWidth)
      ReviewButtonView(recipeId: recipe.id)
        .accessibilityIdentifier("favorite-detail-review-button")
    }
    .accessibilityIdentifier("favorite-recipe-summary")
  }
}

struct FavoriteIngredientsView: View {
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
    .accessibilityIdentifier("favorite-recipe-ingredients")
  }
}

struct FavoriteInstructionsView: View {
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
    .accessibilityIdentifier("favorite-recipe-instructions")
  }
}

struct FavoriteReviewsView: View {
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
    .accessibilityIdentifier("favorite-recipe-reviews")
  }
}

struct FavoriteDetailView_Previews: PreviewProvider {
  static var previews: some View {
    let recipe: [Recipe] = [
      Recipe(
        pricePerServing: 141.03,
        extendedIngredients: [
          ExtendedIngredient(
            id: 18369,
            aisle: "Baking",
            consistency: Consistency(rawValue: "SOLID"),
            name: "baking powder",
            original: "3/4 teaspoon baking powder",
            originalName: "baking powder",
            amount: 0.75,
            unit: "teaspoon",
            meta: [],
            measures: Measures(
              usa: Metric(
                amount: 0.75,
                unitShort: "tsps",
                unitLong: "teaspoons"),
              metric: Metric(
                amount: 0.75,
                unitShort: "tsps",
                unitLong: "teaspoons")
            )
          )
        ],
        id: 633265,
        title: "Bacon & Egg Toast Cups",
        readyInMinutes: 45,
        servings: 2,
        summary:
        """
        It takes about 45 minutes to make one portion of Bacon & Egg Toast Cup.
        """,
        instructions: "Preheat oven to 375.",
        analyzedInstructions: [
          AnalyzedInstruction(
            name: "",
            steps: [
              Step(
                number: 1,
                step: "Preheat oven to 37",
                ingredients: [],
                equipment: [
                  Ent(
                    id: 404784,
                    name: "oven",
                    localizedName: "oven",
                    image: "oven.jpg"
                  )
                ],
                length: nil)
            ])
        ]
      )
    ]

    FavoriteDetailView(recipe: recipe[0])
      .environmentObject(ReviewRecipeViewModel())
      .environmentObject(FavoriteRecipeViewModel())
  }
}
