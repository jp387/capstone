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
    VStack(spacing: Constants.Onboarding.vStackSpacing) {
      Text(detail.emoji)
        .font(.system(size: Constants.Onboarding.emojiFontSize))
      Text(detail.title)
        .font(.system(
          size: Constants.Onboarding.detailFontSize,
          weight: .heavy,
          design: .rounded))
        .padding(.bottom, Constants.Onboarding.detailPadding)
        .foregroundColor(.red)

      Text(detail.content)
        .font(.system(
          size: Constants.Onboarding.detailContentFontSize,
          weight: .light,
          design: .rounded))
        .foregroundColor(.red)

      if detail.last {
        Button {
          isOnboarding = false
        } label: {
          Text("Let's Go!")
            .bold()
            .foregroundColor(.yellow)
            .frame(
              width: Constants.Onboarding.buttonFrameWidth,
              height: Constants.Onboarding.buttonFrameHeight)
            .background(.red)
            .cornerRadius(Constants.Onboarding.buttonRadius)
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
      .background(.yellow)
  }
}
