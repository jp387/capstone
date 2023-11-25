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
      }
      .frame(width: 90, height: 90)

      VStack(alignment: .leading) {
        Text(recipe.title)
          .foregroundColor(.white)
          .multilineTextAlignment(.leading)
          .padding(.bottom, 5)
        if recipe.readyInMinutes >= 60 {
          let hours = Int(recipe.readyInMinutes / 60)
          let minutes = Int(recipe.readyInMinutes - (hours * 60))
          let hoursText = hours > 1 ? "hours" : "hour"

          if minutes == 0 || minutes == 60 {
            Text("Cooking Time: \(hours) \(hoursText)")
              .foregroundColor(.white)
              .font(.caption)
          } else if minutes == 1 {
            Text("Cooking Time: \(hours) \(hoursText) \(minutes) minute")
              .foregroundColor(.white)
              .font(.caption)
          } else {
            Text("Cooking Time: \(hours) \(hoursText) \(minutes) minutes")
              .foregroundColor(.white)
              .font(.caption)
          }
        } else {
          Text("Cooking Time: \(recipe.readyInMinutes) minutes")
            .foregroundColor(.white)
            .font(.caption)
        }
        Text("Serving: \(recipe.servings)")
          .foregroundColor(.white)
          .font(.caption)
      }.padding(.trailing, 20)
      Spacer()
    }
    .frame(maxWidth: .infinity, alignment: .center)
    .background(Color(
      red: 32 / 255,
      green: 36 / 255,
      blue: 38 / 255))
    .modifier(CardModifier())
    .padding(.all, 10)
  }
}
