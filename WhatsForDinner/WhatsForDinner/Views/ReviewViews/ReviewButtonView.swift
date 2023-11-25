//
//  ReviewButtonView.swift
//  LastMinuteMeals
//
//  Created by John Phung on 11/15/23.
//

import SwiftUI

struct ReviewButtonView: View {
  var recipeId: Int
  @State private var isPresented = false
  @EnvironmentObject var reviewRecipeVM: ReviewRecipeViewModel

  var body: some View {
    Button {
      isPresented.toggle()
    } label: {
      ButtonView(systemName: "star.fill", title: "Rate This Recipe")
    }
    .sheet(isPresented: $isPresented) {
      NewReviewFormView(
        displayModal: $isPresented,
        recipeId: recipeId
      )
      .presentationDetents([.medium])
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
        .font(.subheadline)
    }
    .padding(5)
    .overlay(
      RoundedRectangle(cornerRadius: 10)
        .stroke(lineWidth: 2)
    )
  }
}

struct ReviewButtonView_Previews: PreviewProvider {
  static var previews: some View {
    ReviewButtonView(recipeId: 10)
      .environmentObject(ReviewRecipeViewModel())
  }
}
