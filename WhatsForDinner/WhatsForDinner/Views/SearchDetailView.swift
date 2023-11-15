//
//  SearchDetailView.swift
//  WhatsForDinner
//
//  Created by John Phung on 11/14/23.
//

import SwiftUI

struct SearchDetailView: View {
  var result: Result

  var body: some View {
    ScrollView(showsIndicators: false) {
      VStack {
        ResultTitleView(result: result)
        ResultDataView(result: result)
        Divider()
        ResultSummaryView(result: result)
        Divider()
        ResultIngredientsView(result: result)
        Divider()
        ResultInstructionsView(result: result)
      }
    }
    .navigationBarTitleDisplayMode(.inline)
  }
}

struct ResultTitleView: View {
  var result: Result

  var body: some View {
    VStack {
      Text(result.title)
        .font(.headline)
        .frame(width: 350)
      AsyncImage(url: URL(string: "https://spoonacular.com/recipeImages/\(result.id)-480x360.jpg")) { image in
        image
      } placeholder: {
        ProgressView()
      }
      .frame(width: 480, height: 360)
      .background(.gray)
    }
  }
}

struct ResultDataView: View {
  var result: Result

  var pricePerServing: Double {
    return Double(result.pricePerServing / 100.0)
  }

  var hours: Int {
    return Int(result.readyInMinutes / 60)
  }

  var minutes: Int {
    return Int(result.readyInMinutes - (hours * 60))
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
        if result.readyInMinutes >= 60 {
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
          Text("Ready in \(result.readyInMinutes) minutes")
            .font(.subheadline)
        }
      }
      .padding()
    }
  }
}

struct ResultSummaryView: View {
  var result: Result

  var body: some View {
    VStack {
      Text("Summary")
        .padding()
      Text(result.summary)
        .frame(width: 350)
    }
  }
}

struct ResultIngredientsView: View {
  var result: Result

  var body: some View {
    Text("Ingredients")
      .padding()
    VStack(alignment: .leading) {
      ForEach(result.extendedIngredients, id: \.name) { ingredient in
        Text("* \(ingredient.original)")
      }
    }
    .frame(width: 350)
  }
}

struct ResultInstructionsView: View {
  var result: Result

  var body: some View {
    Text("Cooking Instructions")
      .padding()
    VStack(alignment: .leading) {
      if let instructions = result.analyzedInstructions.first {
        ForEach(instructions.steps, id: \.number) { instruction in
          Text("\(String(instruction.number)). \(instruction.step)")
        }
      }
    }
    .frame(width: 350)
  }
}

// struct SearchDetailView_Previews: PreviewProvider {
//   static var previews: some View {
//     SearchDetailView()
//   }
// }
