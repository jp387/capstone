//
//  Constants.swift
//  WhatsForDinner
//
//  Created by John Phung on 11/30/23.
//

import Foundation

enum Constants {
  enum General {
    public static let imageFontSize = CGFloat(30)
    public static let textFontSize = CGFloat(35)
    public static let georgiaFontSize = CGFloat(13)
    public static let georgiaFontLargeSize = CGFloat(18)
    public static let georgiaBoldFontSize = CGFloat(18)
    public static let georgiaBoldFontSmallSize = CGFloat(13)
    public static let animationDuration: Double = 1
  }

  enum HomeView {
    public static let rotationEffectDefault = CGFloat(0)
    public static let rotationEffectFullCircle = CGFloat(360)
  }

  enum DefaultView {
    public static let textFontSize = CGFloat(25)
    public static let textFavoriteFontSize = CGFloat(19)
  }

  enum Service {
    public static let randomRecipeCount = 25
    public static let searchResultCount = 50
  }

  enum SplashScreen {
    public static let meowScriptFontSize = CGFloat(60)
    public static let textRotationInDegrees: Double = -8.37
    public static let animationDelay: Double = 0.5
    public static let taskSleep: Double = 3.5
  }

  enum RecipeCard {
    public static let cardModifierCornerRadius = CGFloat(20)
    public static let cardModifierOpacity: Double = 0.2
    public static let cardModifierRadius = CGFloat(20)
    public static let cardModifierXYAxis = CGFloat(0)
    public static let imageCornerRadius = CGFloat(10)
    public static let imageFrameSize = CGFloat(90)
    public static let imagePadding = CGFloat(10)
    public static let textPadding = CGFloat(5)
    public static let vStackPadding = CGFloat(5)
    public static let hStackPadding = CGFloat(10)
  }

  enum Onboarding {
    public static let vStackSpacing = CGFloat(0)
    public static let emojiFontSize = CGFloat(150)
    public static let detailFontSize = CGFloat(35)
    public static let detailPadding = CGFloat(12)
    public static let detailContentFontSize = CGFloat(18)
    public static let buttonFrameWidth = CGFloat(200)
    public static let buttonFrameHeight = CGFloat(50)
    public static let buttonRadius = CGFloat(6)
  }

  enum ProgressView {
    public static let roundedRectangleCornerRadius = CGFloat(0)
    public static let roundedRectangleOpacity = CGFloat(0.1)
    public static let progressViewPadding = CGFloat(5)
    public static let vStackFrameSize = CGFloat(150)
    public static let vStackCornerRadius = CGFloat(16)
  }

  enum RecipeDetail {
    public static let detailFrameWidth = CGFloat(350)
    public static let headerImageWidth = CGFloat(480)
    public static let headerImageHeight = CGFloat(360)
    public static let reviewPadding = CGFloat(5)
    public static let starFontSize = CGFloat(13)
  }

  enum ReviewForm {
    public static let defaultRating = 1
    public static let defaultLineLimit = 5
  }
}
