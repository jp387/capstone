//
//  DefaultView.swift
//  Homework09
//
//  Created by John Phung on 10/26/23.
//

import SwiftUI

struct NoResultsView: View {
  var body: some View {
    VStack {
      Image(systemName: "magnifyingglass")
        .foregroundColor(.gray)
        .bold()
        .font(.system(size: 30))
        .padding(.bottom, 10)
        .frame(width: 10, height: 10)
      Text("No Results")
        .font(.title2)
        .bold()
      Text("Check the spelling or try a new search.")
        .font(.caption)
        .foregroundColor(.gray)
    }
  }
}

struct NoResultsView_Previews: PreviewProvider {
  static var previews: some View {
    NoResultsView()
  }
}
