//
//  NoRecipesView.swift
//  WhatsForDinner
//
//  Created by John Phung on 11/18/23.
//

import SwiftUI

struct NoRecipesView: View {
  var body: some View {
    VStack {
      Image(systemName: "exclamationmark.circle.fill")
        .font(.system(size: Constants.General.imageFontSize))
        .foregroundColor(.red)
        .bold()
      Text("No recipes to see here!")
        .font(.system(
          size: Constants.General.textFontSize,
          weight: .bold,
          design: .rounded))
        .bold()
      Text("Please try again later.")
        .font(.body)
        .foregroundColor(.gray)
    }
  }
}

struct NoRecipesView_Previews: PreviewProvider {
  static var previews: some View {
    NoRecipesView()
  }
}
