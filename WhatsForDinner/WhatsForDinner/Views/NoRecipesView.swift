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
      Image(systemName: "exclamationmark.arrow.triangle.2.circlepath")
        .foregroundColor(.blue)
        .bold()
        .font(.system(size: 30))
        .padding(.bottom, 10)
        .frame(width: 10, height: 10)
      Text("No recipes to see here!")
        .font(.title2)
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
