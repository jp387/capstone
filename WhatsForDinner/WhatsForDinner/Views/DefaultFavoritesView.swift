//
//  DefaultFavoritesView.swift
//  WhatsForDinner
//
//  Created by John Phung on 11/18/23.
//

import SwiftUI

struct DefaultFavoritesView: View {
  var body: some View {
    VStack {
      Image(systemName: "heart.fill")
        .foregroundColor(.red)
        .bold()
        .font(.system(size: 30))
        .padding(.bottom, 10)
        .frame(width: 10, height: 10)
      Text("You don't have any favorite recipes.")
        .font(.title3)
        .bold()
      Text("Tap the \(Image(systemName: "heart")) to add a recipe!")
        .font(.subheadline)
        .foregroundColor(.gray)
    }
  }
}

struct DefaultFavoritesView_Previews: PreviewProvider {
  static var previews: some View {
    DefaultFavoritesView()
  }
}
