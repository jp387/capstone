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
      AsyncImage(url: URL(string: "https://spoonacular.com/recipeImages/\(recipe.id)-90x90.jpg")) { image in
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
        if recipe.readyInMinutes >= 60 {
          let hours = Int(recipe.readyInMinutes / 60)
          let minutes = Int(recipe.readyInMinutes - (hours * 60))
          let hoursText = hours > 1 ? "hours" : "hour"

          if minutes == 0 || minutes == 60 {
            Text("Cooking Time: \(hours) \(hoursText)")
              .foregroundColor(Color("CardTextColor"))
              .font(.caption)
          } else if minutes == 1 {
            Text("Cooking Time: \(hours) \(hoursText) \(minutes) minute")
              .foregroundColor(Color("CardTextColor"))
              .font(.caption)
          } else {
            Text("Cooking Time: \(hours) \(hoursText) \(minutes) minutes")
              .foregroundColor(Color("CardTextColor"))
              .font(.caption)
          }
        } else {
          Text("Cooking Time: \(recipe.readyInMinutes) minutes")
            .foregroundColor(Color("CardTextColor"))
            .font(.caption)
        }
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
    RecipeCardView(
      recipe: Recipe(
        pricePerServing: 2.0,
        extendedIngredients: [],
        id: 10,
        title: "Recipe",
        readyInMinutes: 45,
        servings: 2,
        summary: "",
        instructions: "",
        analyzedInstructions: [])
    )
    .previewLayout(.sizeThatFits)
  }
}
