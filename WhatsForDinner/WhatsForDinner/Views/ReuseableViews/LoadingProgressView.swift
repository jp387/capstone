//
//  LoadingProgressView.swift
//  WhatsForDinner
//
//  Created by John Phung on 11/20/23.
//

import SwiftUI

struct LoadingProgressView: View {
  var body: some View {
    ZStack {
      RoundedRectangle(cornerRadius: 0)
        .ignoresSafeArea()
        .foregroundColor(.gray)
        .opacity(0.1)
      VStack {
        ProgressView()
          .tint(.blue)
          .controlSize(.large)
          .padding(5)
        Text("Please wait...")
          .font(.title3)
          .fontWeight(.semibold)
          .foregroundColor(.black)
      }
      .frame(width: 150, height: 150)
      .background(.white)
      .cornerRadius(16)
    }
  }
}

struct LoadingProgressView_Previews: PreviewProvider {
  static var previews: some View {
    LoadingProgressView()
  }
}
