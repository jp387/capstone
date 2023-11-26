//
//  SplashScreenView.swift
//  WhatsForDinner
//
//  Created by John Phung on 11/23/23.
//

import SwiftUI

struct SplashScreenView: View {
  @State private var fadeInOut = false
  @Binding var isActive: Bool

  var body: some View {
    ZStack {
      Rectangle()
        .foregroundColor(.red)
        .ignoresSafeArea()
      VStack {
        Text("What's For")
          .font(Font.custom("MeowScript-regular", size: 60))
          .rotationEffect(.degrees(-8.37))
          .foregroundColor(.yellow)
        if fadeInOut {
          Image("dinner")
            .transition(.opacity)
        }
        Text("Dinner?!")
          .font(Font.custom("MeowScript-regular", size: 60))
          .rotationEffect(.degrees(-8.37))
          .foregroundColor(.yellow)
      }
      .animation(.easeInOut(duration: 1).delay(0.5), value: fadeInOut)
      .onAppear {
        self.fadeInOut.toggle()
      }
      .task {
        try? await Task.sleep(for: Duration.seconds(5))
        self.isActive.toggle()
      }
    }
  }
}

struct SplashScreenView_Previews: PreviewProvider {
  static var previews: some View {
    SplashScreenView(isActive: .constant(true))
  }
}
