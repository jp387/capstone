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
      HStack {
        Image(systemName: "heart.slash.fill")
          .font(.system(size: Constants.DefaultView.textFontSize))
        .foregroundColor(.red)
        Text("You don't have any favorite recipes.")
          .font(.system(
            size: Constants.DefaultView.textFavoriteFontSize,
            weight: .bold,
            design: .rounded))
          .bold()
      }
      Text("Tap the \(Image(systemName: "heart")) to favorite a recipe.")
        .font(.subheadline)
        .foregroundColor(.gray)
      Text("Swipe and tap Remove to remove a recipe.")
        .font(.subheadline)
        .foregroundColor(.gray)
    }
    .accessibilityIdentifier("default-favorite-view")
  }
}

struct DefaultFavoritesView_Previews: PreviewProvider {
  static var previews: some View {
    DefaultFavoritesView()
  }
}
