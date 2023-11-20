//
//  RandomRecipeModel+Extension.swift
//  WhatsForDinner
//
//  Created by John Phung on 11/13/23.
//

import Foundation

extension Recipe: Identifiable, Hashable {
  var identifier: String {
    return UUID().uuidString
  }

  static func == (lhs: Recipe, rhs: Recipe) -> Bool {
    return lhs.identifier == rhs.identifier
  }

  func hash(into hasher: inout Hasher) {
    hasher.combine(identifier)
  }
}
