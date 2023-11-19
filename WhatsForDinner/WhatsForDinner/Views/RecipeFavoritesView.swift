//
//  RecipeFavoritesView.swift
//  WhatsForDinner
//
//  Created by John Phung on 11/18/23.
//

import SwiftUI

struct RecipeFavoritesView: View {
  @State private var showDefaultScreen = true

  var body: some View {
    NavigationStack {
      List {
      }
      .navigationTitle("Favorite Recipes")
    }
    .overlay {
      if showDefaultScreen { DefaultFavoritesView() }
    }
  }
}

struct RecipeFavoritesView_Previews: PreviewProvider {
  static var previews: some View {
    RecipeFavoritesView()
  }
}
