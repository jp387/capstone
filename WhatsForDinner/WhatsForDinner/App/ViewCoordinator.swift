//
//  ViewCoordinator.swift
//  WhatsForDinner
//
//  Created by John Phung on 11/23/23.
//

import SwiftUI

struct ViewCoordinator: View {
  @State private var isActive = false

  var body: some View {
    ZStack {
      if isActive {
        ContentView()
      } else {
        SplashScreenView()
      }
    }
  }
}

struct ViewCoordinator_Previews: PreviewProvider {
  static var previews: some View {
    ViewCoordinator()
  }
}
