//
//  OnboardingViewModel.swift
//  WhatsForDinner
//
//  Created by John Phung on 11/23/23.
//

import Foundation

class OnboardingViewModel: ObservableObject {
  @Published private(set) var details: [OnboardingDetails] = []

  func loadDetails() {
    details = [
      OnboardingDetails(
        emoji: "🍲",
        title: "Dinner Ideas",
        content: "We'll get you some dinner ideas to help you make something delicious!"),
      OnboardingDetails(
        emoji: "🔍",
        title: "Search Your Dinner",
        content: "Need help finding dinner ideas? Use our handy search tool to find your next recipe!"),
      OnboardingDetails(
        emoji: "❤️",
        title: "Favorite Your Recipes!",
        content: "Add your favorite dinner recipes so that you can make them for tonight or any other night!")
    ]
  }
}
