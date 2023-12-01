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
        .foregroundColor(.yellow)
        .ignoresSafeArea()
      VStack {
        Text("What's For")
          .font(Font.custom("MeowScript-regular", size: Constants.SplashScreen.meowScriptFontSize))
          .rotationEffect(.degrees(Constants.SplashScreen.textRotationInDegrees))
          .foregroundColor(.red)
        if fadeInOut {
          Image("dinner")
            .transition(.opacity)
        }
        Text("Dinner?!")
          .font(Font.custom("MeowScript-regular", size: Constants.SplashScreen.meowScriptFontSize))
          .rotationEffect(.degrees(Constants.SplashScreen.textRotationInDegrees))
          .foregroundColor(.red)
      }
      .animation(.easeInOut(
        duration: Constants.General.animationDuration)
        .delay(
          Constants.SplashScreen.animationDelay
        ), value: fadeInOut)
      .onAppear {
        self.fadeInOut.toggle()
      }
      .task {
        try? await Task.sleep(for: Duration.seconds(Constants.SplashScreen.taskSleep))
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
