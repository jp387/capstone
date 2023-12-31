//
//  NewReviewFormView.swift
//  WhatsForDinner
//
//  Created by John Phung on 11/15/23.
//

import SwiftUI

struct NewReviewFormView: View {
  @Binding var isPresented: Bool
  @State private var selectedRating = Constants.ReviewForm.defaultRating
  @State private var comments = ""
  @EnvironmentObject var reviewRecipeVM: ReviewRecipeViewModel
  @Environment (
    \.dismiss
  )
  var dismiss

  var recipeId: Int

  var body: some View {
    NavigationStack {
      Form {
        Section("Rating") {
          RatingView(rating: $selectedRating)
        }
        Section("Write a Comment") {
          TextField("", text: $comments, axis: .vertical)
            .lineLimit(Constants.ReviewForm.defaultLineLimit...)
        }
      }
      .accessibilityIdentifier("review-form")
      .navigationBarTitle(Text("Write a Review"), displayMode: .inline)
      .navigationBarItems(
        leading:
          Button(action: {
            dismiss()
          }, label: {
            Text("Cancel")
          })
          .accessibilityIdentifier("form-cancel")
        ,
        trailing:
          Button(action: {
            addReview()
          }, label: {
            Text("Add")
          })
          .disabled(comments.isEmpty)
          .accessibilityIdentifier("form-submit")
      )
    }
  }

  func addReview() {
    reviewRecipeVM.addReview(
      recipeId: recipeId,
      rating: selectedRating,
      comment: comments)
    isPresented.toggle()
  }
}

struct RatingView: View {
  @Binding var rating: Int

  var label = ""
  var maximumRating = 5

  var offImage: Image?
  var onImage = Image(systemName: "star.fill")

  var offColor = Color.gray
  var onColor = Color.yellow

  var body: some View {
    HStack {
      if label.isEmpty == false {
        Text(label)
      }
      ForEach(1..<maximumRating + 1, id: \.self) { number in
        image(for: number)
          .foregroundColor(number > rating ? offColor : onColor)
          .onTapGesture {
            rating = number
          }
      }
    }
  }

  func image(for number: Int) -> Image {
    if number > rating {
      return offImage ?? onImage
    } else {
      return onImage
    }
  }
}

struct NewReviewFormView_Previews: PreviewProvider {
  static var previews: some View {
    NewReviewFormView(
      isPresented: .constant(true),
      recipeId: 10
    )
    .environmentObject(ReviewRecipeViewModel())
  }
}
