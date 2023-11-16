//
//  DefaultView.swift
//  Homework09
//
//  Created by John Phung on 10/26/23.
//

import SwiftUI

struct DefaultSearchView: View {
  var body: some View {
    VStack {
      Image(systemName: "magnifyingglass")
        .foregroundColor(.gray)
        .bold()
        .font(.system(size: 30))
        .padding(.bottom, 10)
        .frame(width: 10, height: 10)
      Text("Unsure What to Cook?")
        .font(.title2)
        .bold()
      Text("Find your dinner here!")
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
