//
//  ViewCoordinator.swift
//  WhatsForDinner
//
//  Created by John Phung on 11/23/23.
//

import SwiftUI

struct ViewCoordinator: View {
  @EnvironmentObject var reviewRecipeVM: ReviewRecipeViewModel
  @EnvironmentObject var favoriteRecipeVM: FavoriteRecipeViewModel

  @State private var isActive = false

  var body: some View {
    ZStack {
      if isActive {
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
