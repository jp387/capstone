//
//  WhatsForDinnerApp.swift
//  WhatsForDinner
//
//  Created by John Phung on 11/12/23.
//

import SwiftUI

@main
struct WhatsForDinnerApp: App {
  @StateObject private var reviewRecipeVM = ReviewRecipeViewModel()
  @StateObject private var favoriteRecipeVM = FavoriteRecipeViewModel()

  var body: some Scene {
    WindowGroup {
      ViewCoordinator()
        .environmentObject(reviewRecipeVM)
        .environmentObject(favoriteRecipeVM)
    }
  }
}
