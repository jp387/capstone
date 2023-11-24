//
//  OnboardingModel.swift
//  WhatsForDinner
//
//  Created by John Phung on 11/23/23.
//

import Foundation

struct OnboardingDetails: Identifiable {
  let id = UUID()
  let emoji: String
  let title: String
  let content: String
}

extension OnboardingDetails: Equatable { }
