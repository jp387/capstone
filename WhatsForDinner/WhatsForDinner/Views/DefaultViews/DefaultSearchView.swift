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
      HStack {
        Image(systemName: "magnifyingglass")
          .font(.system(size: 30))
          .foregroundColor(.yellow)
        .bold()
        Text("Not sure what to cook?!")
          .font(.custom("MeowScript-regular", size: 35))
          .bold()
      }
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
