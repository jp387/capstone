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
        .font(.system(size: 30))
        .foregroundColor(.red)
        .bold()
      Text("No recipes to see here!")
        .font(.custom("MeowScript-regular", size: 35))
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
