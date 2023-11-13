//
//  RecipeDetailView.swift
//  WhatsForDinner
//
//  Created by John Phung on 11/12/23.
//

import SwiftUI

struct RecipeDetailView: View {
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
    ScrollView(showsIndicators: false) {
      VStack {
        Text(recipe.title)
          .font(.subheadline)
        AsyncImage(url: URL(string: "https://spoonacular.com/recipeImages/\(recipe.id)-480x360.jpg")) { image in
          image
        } placeholder: {
          ProgressView()
        }
        .frame(width: 480, height: 360)
        .background(.gray)
        HStack {
          VStack {
            Image("cheap")
            Text("$\(String(format: "%.2f", Double(recipe.pricePerServing / 100.0))) per serving")
          }
          .padding()
          VStack {
            Image("fast")
            if recipe.readyInMinutes > 60 {
              let hoursText = hours > 1 ? "hours" : "hour"
              Text("Ready in \(hours) \(hoursText) \(minutes) minutes")
            } else {
              Text("Ready in \(recipe.readyInMinutes) minutes")
            }
          }
          .padding()
        }
        VStack {
          Text("Summary")
            .padding()
          Text(recipe.summary)
            .frame(width: 350)
        }
        Divider()
        Text("Ingredients")
          .padding()
        VStack(alignment: .leading) {
          ForEach(recipe.extendedIngredients, id: \.name) { ingredient in
            Text("* \(ingredient.original)")
          }
        }
        .frame(width: 350)
        Divider()
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
  }
}

// struct RecipeDetailView_Previews: PreviewProvider {
//   static var previews: some View {
//       RecipeDetailView(recipe: )
//   }
// }
