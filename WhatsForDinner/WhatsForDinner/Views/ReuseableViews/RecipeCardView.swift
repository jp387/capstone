//
//  RecipeCardView.swift
//  WhatsForDinner
//
//  Created by John Phung on 11/24/23.
//

import SwiftUI

struct CardModifier: ViewModifier {
  func body(content: Content) -> some View {
    content
      .cornerRadius(Constants.RecipeCard.cardModifierCornerRadius)
      .shadow(
        color: Color.black.opacity(Constants.RecipeCard.cardModifierOpacity),
        radius: Constants.RecipeCard.cardModifierCornerRadius,
        x: Constants.RecipeCard.cardModifierXYAxis,
        y: Constants.RecipeCard.cardModifierXYAxis)
  }
}

struct RecipeCardView: View {
  var recipe: Recipe

  var body: some View {
    HStack(alignment: .center) {
      AsyncImage(url: recipe.thumbnailURL) { image in
        image
          .resizable()
          .cornerRadius(Constants.RecipeCard.imageCornerRadius)
          .aspectRatio(contentMode: .fit)
          .frame(width: Constants.RecipeCard.imageFrameSize)
          .padding(.all, Constants.RecipeCard.imagePadding)
      } placeholder: {
        ProgressView()
          .tint(.red)
          .controlSize(.large)
      }
      .frame(
        width: Constants.RecipeCard.imageFrameSize,
        height: Constants.RecipeCard.imageFrameSize)

      VStack(alignment: .leading) {
        Text(recipe.title)
          .bold()
          .foregroundColor(Color("CardTextColor"))
          .multilineTextAlignment(.leading)
          .padding(.bottom, Constants.RecipeCard.textPadding)
        recipe.cardCookingTime
        Text("Serving: \(recipe.servings)")
          .foregroundColor(Color("CardTextColor"))
          .font(.caption)
      }
      .padding(.trailing, Constants.RecipeCard.vStackPadding)
      Spacer()
    }
    .frame(maxWidth: .infinity, alignment: .center)
    .background(Color(
      red: 250 / 255,
      green: 250 / 255,
      blue: 250 / 255))
    .modifier(CardModifier())
    .padding(.all, Constants.RecipeCard.hStackPadding)
  }
}

struct RecipeCardView_Previews: PreviewProvider {
  static var previews: some View {
    VStack {
      RecipeCardView(
        recipe: Recipe(
          pricePerServing: 2.0,
          extendedIngredients: [],
          id: 10,
          title: "Recipe",
          readyInMinutes: 1,
          servings: 2,
          summary: "",
          instructions: "",
          analyzedInstructions: [])
      )
      .previewLayout(.sizeThatFits)
      RecipeCardView(
        recipe: Recipe(
          pricePerServing: 2.0,
          extendedIngredients: [],
          id: 10,
          title: "Recipe",
          readyInMinutes: 120,
          servings: 6,
          summary: "",
          instructions: "",
          analyzedInstructions: [])
      )
      .previewLayout(.sizeThatFits)
    }
  }
}
