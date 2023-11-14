//
//  RecipeSearchView.swift
//  WhatsForDinner
//
//  Created by John Phung on 11/13/23.
//

import SwiftUI

struct RecipeSearchView: View {
  @Binding var searchResults: String
  var body: some View {
    NavigationStack {
      VStack {
      }
      .searchable(text: $searchResults, prompt: "Search your dinner here...")
    }
  }
}

struct RecipeSearchView_Previews: PreviewProvider {
  static var previews: some View {
    RecipeSearchView(searchResults: .constant("chicken"))
  }
}
