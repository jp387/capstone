//
//  OnboardingDetailView.swift
//  WhatsForDinner
//
//  Created by John Phung on 11/23/23.
//

import SwiftUI

struct OnboardingDetailView: View {
  @AppStorage(
    "isOnboarding"
  )
  var isOnboarding = true

  let detail: OnboardingDetails

  var body: some View {
    VStack(spacing: 0) {
      Text(detail.emoji)
        .font(.system(size: 150))
      Text(detail.title)
        .font(.system(size: 35, weight: .heavy, design: .rounded))
        .padding(.bottom, 12)
        .foregroundColor(.yellow)

      Text(detail.content)
        .font(.system(size: 18, weight: .light, design: .rounded))
        .foregroundColor(.yellow)

      if detail.last {
        Button {
          isOnboarding = false
        } label: {
          Text("Let's Go!")
            .bold()
            .foregroundColor(.red)
            .frame(width: 200, height: 50)
            .background(.yellow)
            .cornerRadius(6)
        }
        .accessibilityIdentifier("onboarding-button")
        .padding()
      }
    }
    .multilineTextAlignment(.center)
    .foregroundColor(.white)
    .padding()
  }
}

struct OnboardingDetailView_Previews: PreviewProvider {
  static var previews: some View {
    OnboardingDetailView(detail: OnboardingDetails(
      emoji: "🎉",
      title: "Get those recipes",
      content: "Making dinner tonight? Use our app!",
      last: true))
      .previewLayout(.sizeThatFits)
      .background(.red)
  }
}
