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
    Button {
      isPresented.toggle()
    } label: {
      ButtonView()
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
  var body: some View {
    HStack {
      Image(systemName: "star.fill")
        .foregroundColor(.yellow)
        .padding(.bottom, 5)
      Text("Rate This Recipe")
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
