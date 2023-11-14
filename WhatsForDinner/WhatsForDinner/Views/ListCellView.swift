//
//  ListCellView.swift
//  WhatsForDinner
//
//  Created by John Phung on 11/13/23.
//

import SwiftUI

struct ListCellView: View {
  var recipe: Recipe

  var body: some View {
    HStack {
      ImageView(recipe: recipe)
      TitleTextView(recipe: recipe)
    }
  }
}

struct ImageView: View {
  var recipe: Recipe

  var body: some View {
    AsyncImage(url: URL(string: "https://spoonacular.com/recipeImages/\(recipe.id)-90x90.jpg")) { image in
      image
    } placeholder: {
      ProgressView()
    }
    .frame(width: 90, height: 90)
    .background(.gray)
  }
}

struct TitleTextView: View {
  var recipe: Recipe

  var body: some View {
    VStack(alignment: .leading) {
      Text(recipe.title)
      if recipe.readyInMinutes >= 60 {
        let hours = Int(recipe.readyInMinutes / 60)
        let minutes = Int(recipe.readyInMinutes - (hours * 60))
        let hoursText = hours > 1 ? "hours" : "hour"

        if minutes == 0 || minutes == 60 {
          Text("Cooking Time: \(hours) \(hoursText)")
            .font(.caption)
        } else if minutes == 1 {
          Text("Cooking Time: \(hours) \(hoursText) \(minutes) minute")
            .font(.caption)
        } else {
          Text("Cooking Time: \(hours) \(hoursText) \(minutes) minutes")
            .font(.caption)
        }
      } else {
        Text("Cooking Time: \(recipe.readyInMinutes) minutes")
          .font(.caption)
      }
      Text("Serving: \(recipe.servings)")
        .font(.caption)
    }
  }
}

// struct ListCellView_Previews: PreviewProvider {
//   static var previews: some View {
//     ListCellView()
//   }
// }
