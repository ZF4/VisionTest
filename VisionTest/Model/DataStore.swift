//
//  DataStore.swift
//  VisionTest
//
//  Created by Zachary Farmer on 7/10/23.
//

import Foundation
import Combine
import VisionKit

class DataStore: ObservableObject {
  static var shared = DataStore()

  @Published var collectedItems: [StoredItem] = []
  @Published var allTransientItems: [TransientItem] = []

  func keepItem(_ newitem: StoredItem) {
    let index = collectedItems.firstIndex { item in
      item.id == newitem.id
    }

    guard index == nil else {
      return
    }

    collectedItems.append(newitem)
  }

  func deleteItem(_ newitem: StoredItem) {
    guard let index = collectedItems.firstIndex(where: { item in
      item.id == newitem.id
    }) else {
      return
    }
    collectedItems.remove(at: index)
  }

  func addThings(_ newItems: [TransientItem], allItems: [TransientItem]) {
    allTransientItems = allItems
  }

  func updateThings(_ changedItems: [TransientItem], allItems: [TransientItem]) {
    allTransientItems = allItems
  }

  func removeThings(_ removedItems: [TransientItem], allItems: [TransientItem]) {
    allTransientItems = allItems
  }
}

extension DataStore {
  static let storageKey = "CollectedItems"

  func saveKeptItems() {
    let encoder = JSONEncoder()
    do {
      let data = try encoder.encode(collectedItems)
      UserDefaults.standard.set(data, forKey: DataStore.storageKey)
    } catch {
      print("save failure -\(error)")
    }
  }

  func restoreKeptItems() {
    do {
      guard let data = UserDefaults.standard.data(
        forKey: DataStore.storageKey
      ) else {
        return
      }

      let decoder = JSONDecoder()
      let items = try decoder.decode([StoredItem].self, from: data)
      collectedItems = items
    } catch {
      print("restore failure -\(error)")
    }
  }
}
