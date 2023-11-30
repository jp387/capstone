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
      .cornerRadius(20)
      .shadow(color: Color.black.opacity(0.2), radius: 20, x: 0, y: 0)
  }
}

struct RecipeCardView: View {
  var recipe: Recipe

  var body: some View {
    HStack(alignment: .center) {
      AsyncImage(url: recipe.thumbnailURL) { image in
        image
          .resizable()
          .cornerRadius(10)
          .aspectRatio(contentMode: .fit)
          .frame(width: 90)
          .padding(.all, 10)
      } placeholder: {
        ProgressView()
          .tint(.red)
          .controlSize(.large)
      }
      .frame(width: 90, height: 90)

      VStack(alignment: .leading) {
        Text(recipe.title)
          .bold()
          .foregroundColor(Color("CardTextColor"))
          .multilineTextAlignment(.leading)
          .padding(.bottom, 5)
        recipe.cardCookingTime
        Text("Serving: \(recipe.servings)")
          .foregroundColor(Color("CardTextColor"))
          .font(.caption)
      }
      .padding(.trailing, 20)
      Spacer()
    }
    .frame(maxWidth: .infinity, alignment: .center)
    .background(Color(
      red: 250 / 255,
      green: 250 / 255,
      blue: 250 / 255))
    .modifier(CardModifier())
    .padding(.all, 10)
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
