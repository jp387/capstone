//
//  OnboardingView.swift
//  WhatsForDinner
//
//  Created by John Phung on 11/23/23.
//

import SwiftUI

struct OnboardingView: View {
  @StateObject private var onboardingVM = OnboardingViewModel()
  @State private var showButton = false
  @Binding var isActive: Bool

  var body: some View {
    ZStack {
      Color.red.ignoresSafeArea()

      if !onboardingVM.details.isEmpty {
        TabView {
          ForEach(onboardingVM.details) { detail in
            OnboardingDetailView(isActive: $isActive, detail: detail)
          }
        }
        .tabViewStyle(.page)
        .indexViewStyle(.page(backgroundDisplayMode: .never))
      }
    }
    .onAppear(perform: onboardingVM.loadDetails)
  }
}

struct OnboardingView_Previews: PreviewProvider {
  static var previews: some View {
    OnboardingView(isActive: .constant(true))
  }
}
