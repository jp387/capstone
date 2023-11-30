//
//  ReviewButtonView.swift
//  WhatsForDinner
//
//  Created by John Phung on 11/15/23.
//

import SwiftUI

struct ReviewButtonView: View {
  var recipeId: Int
  @State private var isPresented = false
  @EnvironmentObject var reviewRecipeVM: ReviewRecipeViewModel

  var body: some View {
    VStack {
      Button {
        isPresented.toggle()
      } label: {
        ButtonView(systemName: "star.fill", title: "Rate This Recipe")
          .accessibilityIdentifier("review-button")
      }
      .buttonStyle(.borderedProminent)
      .tint(.red)
      .sheet(isPresented: $isPresented) {
        NewReviewFormView(
          isPresented: $isPresented,
          recipeId: recipeId
        )
        .presentationDetents([.medium])
        .accessibilityIdentifier("review-sheet")
      }
    }
  }
}

struct ButtonView: View {
  var systemName: String
  var title: String

  var body: some View {
    HStack {
      Image(systemName: systemName)
        .foregroundColor(.yellow)
        .padding(.bottom, 5)
      Text(title)
        .bold()
        .font(.subheadline)
        .foregroundColor(.yellow)
    }
  }
}

struct ReviewButtonView_Previews: PreviewProvider {
  static var previews: some View {
    ReviewButtonView(recipeId: 10)
      .environmentObject(ReviewRecipeViewModel())
  }
}
