//
//  DefaultSearchView.swift
//  WhatsForDinner
//
//  Created by John Phung on 10/26/23.
//

import SwiftUI

struct DefaultSearchView: View {
  var body: some View {
    VStack {
      Image(systemName: "magnifyingglass")
        .font(.system(size: 30))
        .foregroundColor(.gray)
        .bold()
      Text("Unsure What to Cook?")
        .font(.title2)
        .bold()
      Text("Find your dinner recipes here!")
        .font(.subheadline)
        .foregroundColor(.gray)
    }
  }
}

struct DefaultSearchView_Previews: PreviewProvider {
  static var previews: some View {
    DefaultSearchView()
  }
}
