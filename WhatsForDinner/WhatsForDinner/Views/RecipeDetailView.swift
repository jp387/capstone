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
        TitleView(recipe: recipe)
        DataView(recipe: recipe)
        Divider()
        SummaryView(recipe: recipe)
        Divider()
        IngredientsView(recipe: recipe)
        Divider()
        InstructionsView(recipe: recipe)
        Divider()
        ReviewsView(recipe: recipe)
      }
    }
    .navigationBarTitleDisplayMode(.inline)
  }
}

struct TitleView: View {
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
        }
        .frame(width: 480, height: 360)
        .background(.gray)
        FavoriteButtonView(recipe: recipe)
          .padding()
          .offset(x: 180, y: -160)
      }
    }
  }
}

struct DataView: View {
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
  }
}

struct SummaryView: View {
  var recipe: Recipe
  @EnvironmentObject var reviewRecipeVM: ReviewRecipeViewModel

  var body: some View {
    VStack {
      Text("Summary")
        .padding()
      Text(recipe.summary.stripHTML)
        .frame(width: 350)
      ReviewButtonView(recipeId: recipe.id)
    }
  }
}

struct IngredientsView: View {
  var recipe: Recipe

  var body: some View {
    Text("Ingredients")
      .padding()
    VStack(alignment: .leading) {
      ForEach(recipe.extendedIngredients, id: \.name) { ingredient in
        Text("* \(ingredient.original)")
      }
    }
    .frame(width: 350)
  }
}

struct InstructionsView: View {
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
  }
}

struct ReviewsView: View {
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
        .foregroundColor(favoriteRecipeExist ? .red : .white)
    }
  }

  func addFavorites() {
    favoriteRecipeVM.addFavorite(recipeId: recipe.id, recipe: recipe)
  }

  func deleteFavorites() {
    favoriteRecipeVM.removeFavorite(by: recipe.id)
  }
}

// struct RecipeDetailView_Previews: PreviewProvider {
//   static var previews: some View {
//       RecipeDetailView(recipe: )
//   }
// }
