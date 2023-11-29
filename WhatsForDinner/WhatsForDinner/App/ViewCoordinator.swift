//
//  ViewCoordinator.swift
//  WhatsForDinner
//
//  Created by John Phung on 11/23/23.
//

import SwiftUI

struct ViewCoordinator: View {
  @State private var isActive = false
  @AppStorage(
    "isOnboarding"
  )
  var isOnboarding = true

  var body: some View {
    ZStack {
      if isOnboarding && isActive {
        OnboardingView()
      } else if !isOnboarding && isActive {
        ContentView()
      } else {
        SplashScreenView(isActive: $isActive)
      }
    }
  }
}

struct ViewCoordinator_Previews: PreviewProvider {
  static var previews: some View {
    ViewCoordinator()
      .environmentObject(ReviewRecipeViewModel())
      .environmentObject(FavoriteRecipeViewModel())
  }
}
