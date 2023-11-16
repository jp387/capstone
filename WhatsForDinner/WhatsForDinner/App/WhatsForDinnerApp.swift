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

  var body: some Scene {
    WindowGroup {
      ContentView()
        .environmentObject(reviewRecipeVM)
    }
  }
}
