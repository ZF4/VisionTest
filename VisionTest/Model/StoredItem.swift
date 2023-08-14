//
//  StoredItem.swift
//  VisionTest
//
//  Created by Zachary Farmer on 7/10/23.
//

import Foundation
import VisionKit

struct StoredItem: Identifiable, Codable {
  enum ItemType: Codable {
    case barcode
    case text
  }

  var id: UUID
  var string: String?
  var type: ItemType
  var barcodeSymbology: String?
  var dateCreated = Date()
}

extension StoredItem {
  var icon: String {
    if type == .text {
      return "text.bubble"
    } else {
      return "barcode"
    }
  }
}
