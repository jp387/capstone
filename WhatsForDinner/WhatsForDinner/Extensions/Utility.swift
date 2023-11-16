//
//  Utility.swift
//  WhatsForDinner
//
//  Created by John Phung on 11/15/23.
//

import Foundation

extension String {
  var stripHTML: String {
    return self.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression)
  }
}
