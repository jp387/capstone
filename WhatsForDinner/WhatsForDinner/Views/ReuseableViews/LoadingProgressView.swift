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
      RoundedRectangle(cornerRadius: Constants.ProgressView.roundedRectangleCornerRadius)
        .ignoresSafeArea()
        .foregroundColor(.gray)
        .opacity(Constants.ProgressView.roundedRectangleOpacity)
      VStack {
        ProgressView()
          .tint(.yellow)
          .controlSize(.large)
          .padding(Constants.ProgressView.progressViewPadding)
        Text("Please wait...")
          .font(.title3)
          .fontWeight(.semibold)
          .foregroundColor(.black)
      }
      .frame(
        width: Constants.ProgressView.vStackFrameSize,
        height: Constants.ProgressView.vStackFrameSize)
      .background(.white)
      .cornerRadius(Constants.ProgressView.vStackCornerRadius)
    }
  }
}

struct LoadingProgressView_Previews: PreviewProvider {
  static var previews: some View {
    LoadingProgressView()
  }
}
