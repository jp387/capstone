//
//  NoResultsView.swift
//  WhatsForDinner
//
//  Created by John Phung on 10/26/23.
//

import SwiftUI

struct NoResultsView: View {
  var body: some View {
    VStack {
      Image(systemName: "magnifyingglass")
        .font(.system(size: 30))
        .foregroundColor(.gray)
        .bold()
      Text("No Results")
        .font(.title2)
        .bold()
      Text("Check the spelling or try a new search.")
        .font(.subheadline)
        .foregroundColor(.gray)
    }
  }
}

struct NoResultsView_Previews: PreviewProvider {
  static var previews: some View {
    NoResultsView()
  }
}
